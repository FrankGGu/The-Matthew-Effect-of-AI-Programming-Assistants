#define MAX_SIZE 1000

char** stringMatching(char** words, int wordsSize, int* returnSize) {
    char** result = (char**)malloc(MAX_SIZE * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordsSize; j++) {
            if (i != j && strstr(words[j], words[i]) != NULL) {
                result[(*returnSize)++] = words[i];
                break;
            }
        }
    }

    return result;
}