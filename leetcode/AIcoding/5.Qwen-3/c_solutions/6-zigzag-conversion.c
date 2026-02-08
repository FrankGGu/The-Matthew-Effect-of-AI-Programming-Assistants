#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* convert(char* s, int numRows) {
    if (numRows == 1 || numRows >= strlen(s)) {
        return s;
    }

    char** rows = (char**)malloc(numRows * sizeof(char*));
    for (int i = 0; i < numRows; i++) {
        rows[i] = (char*)malloc((strlen(s) + 1) * sizeof(char));
    }

    int direction = -1;
    int currentRow = 0;

    for (int i = 0; i < strlen(s); i++) {
        rows[currentRow][i] = s[i];
        if (currentRow == 0 || currentRow == numRows - 1) {
            direction *= -1;
        }
        currentRow += direction;
    }

    char* result = (char*)malloc((strlen(s) + 1) * sizeof(char));
    int index = 0;
    for (int i = 0; i < numRows; i++) {
        for (int j = 0; j < strlen(s); j++) {
            if (rows[i][j] != '\0') {
                result[index++] = rows[i][j];
            }
        }
        free(rows[i]);
    }
    free(rows);
    result[index] = '\0';
    return result;
}