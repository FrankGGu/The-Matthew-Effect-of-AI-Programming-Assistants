#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* numberOfLines(int* widths, int widthsSize, char * s, int* returnSize){
    int lines = 1;
    int current_width = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        int width = widths[s[i] - 'a'];
        if (current_width + width > 100) {
            lines++;
            current_width = width;
        } else {
            current_width += width;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = lines;
    result[1] = current_width;
    *returnSize = 2;
    return result;
}