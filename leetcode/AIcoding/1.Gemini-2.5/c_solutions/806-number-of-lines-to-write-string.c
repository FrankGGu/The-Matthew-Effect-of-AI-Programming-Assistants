#include <stdlib.h>
#include <string.h>

int* numberOfLines(int* widths, int widthsSize, char* s, int* returnSize) {
    int lines = 1;
    int currentLineWidth = 0;
    int i = 0;

    while (s[i] != '\0') {
        int charWidth = widths[s[i] - 'a'];
        if (currentLineWidth + charWidth > 100) {
            lines++;
            currentLineWidth = charWidth;
        } else {
            currentLineWidth += charWidth;
        }
        i++;
    }

    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = lines;
    result[1] = currentLineWidth;
    *returnSize = 2;
    return result;
}