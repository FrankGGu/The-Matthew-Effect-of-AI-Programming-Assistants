/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findWordsContaining(char** words, int wordsSize, char x, int* returnSize) {
    int* result = (int*)malloc(wordsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        while (*word != '\0') {
            if (*word == x) {
                result[(*returnSize)++] = i;
                break;
            }
            word++;
        }
    }

    return result;
}