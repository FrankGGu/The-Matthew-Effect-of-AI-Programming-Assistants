#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **removeAnagrams(char **words, int wordsSize, int *returnSize) {
    char **result = (char **)malloc(wordsSize * sizeof(char *));
    int resultIndex = 0;

    for (int i = 0; i < wordsSize; i++) {
        int isAnagram = 0;
        for (int j = 0; j < resultIndex; j++) {
            if (strlen(result[j]) == strlen(words[i])) {
                int count[26] = {0};
                for (int k = 0; k < strlen(words[i]); k++) {
                    count[words[i][k] - 'a']++;
                }
                int match = 1;
                for (int k = 0; k < strlen(result[j]); k++) {
                    if (count[result[j][k] - 'a'] <= 0) {
                        match = 0;
                        break;
                    }
                    count[result[j][k] - 'a']--;
                }
                if (match) {
                    isAnagram = 1;
                    break;
                }
            }
        }
        if (!isAnagram) {
            result[resultIndex++] = strdup(words[i]);
        }
    }

    *returnSize = resultIndex;
    return result;
}