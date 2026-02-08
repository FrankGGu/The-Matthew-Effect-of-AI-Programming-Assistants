#include <stdlib.h>
#include <string.h>

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

int getLowerBound(char** products, int productsSize, const char* searchWord, int prefixLen) {
    int low = 0;
    int high = productsSize; // Search range is [low, high)

    while (low < high) {
        int mid = low + (high - low) / 2;
        // strncmp(s1, s2, n) returns:
        //   < 0 if s1 prefix is lexicographically smaller than s2 prefix
        //   > 0 if s1 prefix is lexicographically greater than s2 prefix
        //   0 if prefixes are identical
        // This is exactly what is needed for lower_bound: find the first element >= target.
        // If products[mid] is smaller than the search prefix, it's definitely not the lower_bound, so search in the right half.
        // Otherwise (products[mid] is equal or greater than the search prefix), it could be the lower_bound, so try searching in the left half for an even earlier match.
        if (strncmp(products[mid], searchWord, prefixLen) < 0) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low; // This is the lower_bound index
}

char*** suggestedProducts(char** products, int productsSize, char* searchWord, int* returnSize, int** returnColumnSizes) {
    // 1. Sort products lexicographically
    qsort(products, productsSize, sizeof(char*), compareStrings);

    int searchWordLen = strlen(searchWord);

    // Allocate memory for the result structure
    char*** result = (char***)malloc(sizeof(char**) * searchWordLen);
    *returnSize = searchWordLen;
    *returnColumnSizes = (int*)malloc(sizeof(int) * searchWordLen);

    // Iterate through each prefix of searchWord
    for (int i = 0; i < searchWordLen; i++) {
        int currentPrefixLen = i + 1;

        // Find the starting index for products matching the current prefix using binary search
        int startIdx = getLowerBound(products, productsSize, searchWord, currentPrefixLen);

        // Allocate space for up to 3 suggestions for the current prefix
        result[i] = (char**)malloc(sizeof(char*) * 3);
        int currentSuggestionsCount = 0;

        // Collect up to 3 suggestions starting from startIdx
        for (int j = 0; j < 3; j++) {
            int productIdx = startIdx + j;

            // Check bounds and if the product actually starts with the current prefix
            if (productIdx < productsSize &&
                strlen(products[productIdx]) >= currentPrefixLen && // Product must be at least as long as the prefix
                strncmp(products[productIdx], searchWord, currentPrefixLen) == 0) { // And must match the prefix characters

                // Allocate memory for the suggestion string and copy it
                result[i][currentSuggestionsCount] = (char*)malloc(sizeof(char) * (strlen(products[productIdx]) + 1));
                strcpy(result[i][currentSuggestionsCount], products[productIdx]);
                currentSuggestionsCount++;
            } else {
                // No more matching products or reached end of products array or product doesn't match prefix
                break;
            }
        }
        (*returnColumnSizes)[i] = currentSuggestionsCount;
    }

    return result;
}