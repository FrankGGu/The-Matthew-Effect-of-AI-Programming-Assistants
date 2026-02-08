#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxRepeating(char *sequence, char *word) {
    int count = 0;
    int len = strlen(word);
    int seqLen = strlen(sequence);
    char *temp = (char *)malloc((len + 1) * sizeof(char));
    strcpy(temp, word);

    while (1) {
        if (strstr(sequence, temp) != NULL) {
            count++;
            temp = (char *)realloc(temp, (strlen(temp) + len + 1) * sizeof(char));
            strcat(temp, word);
        } else {
            break;
        }
    }

    free(temp);
    return count;
}