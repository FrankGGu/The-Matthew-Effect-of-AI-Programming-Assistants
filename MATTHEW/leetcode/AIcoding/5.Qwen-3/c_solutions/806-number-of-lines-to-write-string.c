#include <stdio.h>
#include <stdlib.h>

int* numberOfLines(int* widths, int widthsSize, char* s, int* returnSize) {
    int lines = 1;
    int width = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        int charWidth = widths[s[i] - 'a'];
        if (width + charWidth > 100) {
            lines++;
            width = charWidth;
        } else {
            width += charWidth;
        }
    }
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = lines;
    result[1] = width;
    *returnSize = 2;
    return result;
}