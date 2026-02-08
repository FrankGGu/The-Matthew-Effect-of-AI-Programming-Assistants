typedef struct {
    char** array;
    int size;
} List;

void backtrack(char* s, int start, List* result, char** current, int* currentSize, int* returnSize) {
    if (start == strlen(s)) {
        result->array[*returnSize] = malloc(sizeof(char*) * (*currentSize));
        for (int i = 0; i < *currentSize; i++) {
            result->array[*returnSize][i] = strdup(current[i]);
        }
        (*returnSize)++;
        return;
    }
    for (int end = start; end < strlen(s); end++) {
        int left = start, right = end;
        while (left < right && s[left] == s[right]) {
            left++;
            right--;
        }
        if (left >= right) {
            current[*currentSize] = strndup(s + start, end - start + 1);
            (*currentSize)++;
            backtrack(s, end + 1, result, current, currentSize, returnSize);
            (*currentSize)--;
        }
    }
}

List partition(char* s) {
    List result;
    result.array = malloc(sizeof(char*) * 1000);
    result.size = 0;
    int returnSize = 0;
    char** current = malloc(sizeof(char*) * strlen(s));
    int currentSize = 0;
    backtrack(s, 0, &result, current, &currentSize, &returnSize);
    free(current);
    result.size = returnSize;
    return result;
}

char*** partitionPalindrome(char* s, int* returnSize, int** returnColumnSizes) {
    List result = partition(s);
    *returnSize = result.size;
    *returnColumnSizes = malloc(sizeof(int) * result.size);
    char*** res = malloc(sizeof(char**) * result.size);
    for (int i = 0; i < result.size; i++) {
        res[i] = result.array[i];
        (*returnColumnSizes)[i] = result.size;
    }
    free(result.array);
    return res;
}