#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *compressString(char *message) {
    int len = strlen(message);
    char *result = (char *)malloc((len + 1) * sizeof(char));
    int index = 0;
    int i = 0;

    while (i < len) {
        char currentChar = message[i];
        int count = 0;

        while (i < len && message[i] == currentChar) {
            i++;
            count++;
        }

        sprintf(result + index, "%c%d", currentChar, count);
        index += 2 + (count >= 10 ? 1 : 0);
    }

    result[index] = '\0';
    return result;
}