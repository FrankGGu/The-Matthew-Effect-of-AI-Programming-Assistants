#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char* word;
    int count;
} WordCount;

int compareStrings(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

int compareWordCountSearch(const void* key, const void* elem) {
    return strcmp((char*)key, ((WordCount*)elem)->word);
}

int* findSubstring(char* s, char** words, int wordsSize, int* returnSize) {
    *returnSize = 0;
    if (s == NULL || *s == '\0' || words == NULL || wordsSize == 0) {
        return NULL;
    }

    int sLen = strlen(s);
    int wordLen = strlen(words[0]); // All words have the same length
    int totalWordsLen = wordLen * wordsSize;

    if (sLen < totalWordsLen) {
        return NULL;
    }

    // 1. Create a frequency map for the given words
    // Sort the input 'words' array to easily consolidate unique words and their counts.
    qsort(words, wordsSize, sizeof(char*), compareStrings);

    // Dynamically allocate an array to store unique words and their required counts.
    // Max size is wordsSize, will realloc to actual uniqueWordsCount.
    WordCount* requiredFreqMap = (WordCount*)malloc(wordsSize * sizeof(WordCount));
    int uniqueWordsCount = 0;

    if (wordsSize > 0) {
        requiredFreqMap[uniqueWordsCount].word = words[0]; // Point to the original string
        requiredFreqMap[uniqueWordsCount].count = 1;
        uniqueWordsCount++;

        for (int i = 1; i < wordsSize; i++) {
            if (strcmp(words[i], words[i-1]) == 0) {
                requiredFreqMap[uniqueWordsCount-1].count++;
            } else {
                requiredFreqMap[uniqueWordsCount].word = words[i];
                requiredFreqMap[uniqueWordsCount].count = 1;
                uniqueWordsCount++;
            }
        }
    }
    requiredFreqMap = (WordCount*)realloc(requiredFreqMap, uniqueWordsCount * sizeof(WordCount));

    // Array to store the starting indices of valid substrings
    int* result = (int*)malloc((sLen / totalWordsLen + 1) * sizeof(int));
    int resultCapacity = sLen / totalWordsLen + 1;
    int currentResultCount = 0;

    // Buffer for extracted words
    char tempWord[wordLen + 1];
    tempWord[wordLen] = '\0';

    // 2. Optimized sliding window: Iterate 'wordLen' times, each time processing a "track"
    // This handles all possible alignments of the concatenated words within 's'.
    for (int start_offset = 0; start_offset < wordLen; start_offset++) {
        // 'currentCounts' will store the frequency of words found in the current window.
        // It's indexed corresponding to 'requiredFreqMap'.
        int* currentCounts = (int*)calloc(uniqueWordsCount, sizeof(int));
        int wordsMatched = 0; // Number of words in the current window that match required counts

        // 'left' pointer for the sliding window of words
        for (int left = start_offset, right = start_offset;
             right <= sLen - wordLen;
             right += wordLen) { // 'right' pointer for adding a new word to window

            // Extract the word at 'right'
            strncpy(tempWord, s + right, wordLen);

            // Find the word in requiredFreqMap using binary search
            WordCount* foundEntry = (WordCount*)bsearch(
                (char*)tempWord,            // Key to search for
                requiredFreqMap,            // Array to search in
                uniqueWordsCount,           // Number of elements
                sizeof(WordCount),          // Size of each element
                compareWordCountSearch      // Comparator function
            );

            int foundIdx = -1;
            if (foundEntry != NULL) {
                foundIdx = foundEntry - requiredFreqMap;
            }

            // Case 1: Word not found in the original list
            if (foundIdx == -1) {
                // This word is not part of the required words. Reset the window.
                memset(currentCounts, 0, uniqueWordsCount * sizeof(int)); // Clear all counts
                wordsMatched = 0;
                left = right + wordLen; // Move left pointer past the invalid word
            } else {
                // Case 2: Word is valid, add to current window counts
                currentCounts[foundIdx]++;

                if (currentCounts[foundIdx] <= requiredFreqMap[foundIdx].count) {
                    wordsMatched++;
                } else {
                    // Case 3: This word's count exceeds the required. Shrink window from left.
                    while (currentCounts[foundIdx] > requiredFreqMap[foundIdx].count) {
                        strncpy(tempWord, s + left, wordLen); // Word to remove from left
                        // This bsearch should always find the word, as it was previously added
                        WordCount* leftEntry = (WordCount*)bsearch(
                            (char*)tempWord,
                            requiredFreqMap,
                            uniqueWordsCount,
                            sizeof(WordCount),
                            compareWordCountSearch
                        );
                        int leftIdx = leftEntry - requiredFreqMap;

                        currentCounts[leftIdx]--;
                        if (currentCounts[leftIdx] < requiredFreqMap[leftIdx].count) {
                            wordsMatched--; // Only decrement if it was a 'matched' word
                        }
                        left += wordLen;
                    }
                }

                // Check if we have a valid concatenation (window size is exactly totalWordsLen)
                if (wordsMatched == wordsSize) {
                    // Found a valid substring starting at 'left'
                    if (currentResultCount == resultCapacity) {
                        resultCapacity *= 2;
                        result = (int*)realloc(result, resultCapacity * sizeof(int));
                    }
                    result[currentResultCount++] = left;

                    // To slide the window one word to the right for the next potential match:
                    // Remove the leftmost word from the current window.
                    strncpy(tempWord, s + left, wordLen); // Word to remove from left
                    WordCount* leftEntry = (WordCount*)bsearch(
                        (char*)tempWord,
                        requiredFreqMap,
                        uniqueWordsCount,
                        sizeof(WordCount),
                        compareWordCountSearch
                    );
                    int leftIdx = leftEntry - requiredFreqMap; 

                    currentCounts[leftIdx]--;
                    wordsMatched--; // Decrement matched count because we removed a valid word
                    left += wordLen;
                }
            }
        }
        free(currentCounts);
    }

    free(requiredFreqMap);
    *returnSize = currentResultCount;
    return result;
}