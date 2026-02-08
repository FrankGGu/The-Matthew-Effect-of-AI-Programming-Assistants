#include <stdlib.h>
#include <string.h>

int* removeAnagrams(char **words, int wordsSize, int* returnSize) {
    char **result = (char**)malloc(wordsSize * sizeof(char*));
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int len = strlen(word);
        char *sortedWord = (char*)malloc((len + 1) * sizeof(char));
        strcpy(sortedWord, word);
        qsort(sortedWord, len, sizeof(char), (int(*)(const void*, const void*))strcmp);

        if (count == 0 || strcmp(sortedWord, result[count - 1]) != 0) {
            result[count++] = words[i];
        }

        free(sortedWord);
    }

    *returnSize = count;
    return result;
}