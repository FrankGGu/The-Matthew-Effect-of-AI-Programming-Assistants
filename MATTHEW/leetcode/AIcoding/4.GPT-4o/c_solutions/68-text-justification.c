#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **fullJustify(char **words, int wordsSize, int maxWidth, int *returnSize) {
    char **result = (char **)malloc(sizeof(char *) * wordsSize);
    *returnSize = 0;
    int count, last, lineLength;

    for (int i = 0; i < wordsSize; ) {
        count = lineLength = 0;
        last = i;

        while (i < wordsSize && lineLength + strlen(words[i]) + count <= maxWidth) {
            lineLength += strlen(words[i++]);
            count++;
        }

        int lineWidth = maxWidth - lineLength;
        char *line = (char *)malloc(sizeof(char) * (maxWidth + 1));
        line[0] = '\0';

        for (int j = last; j < i; j++) {
            strcat(line, words[j]);
            if (j < i - 1) {
                int spaces = 1 + (lineWidth > 0 ? lineWidth / (count - 1) : 0);
                lineWidth -= spaces;
                for (int k = 0; k < spaces; k++) {
                    strcat(line, " ");
                }
            }
        }

        if (count == 1 || i == wordsSize) {
            while (strlen(line) < maxWidth) {
                strcat(line, " ");
            }
        }

        result[(*returnSize)++] = line;
    }

    return result;
}