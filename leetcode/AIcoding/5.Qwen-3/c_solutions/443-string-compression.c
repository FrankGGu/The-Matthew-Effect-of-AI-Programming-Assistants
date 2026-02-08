#include <stdio.h>
#include <stdlib.h>

int compress(char* chars, int charsSize) {
    int index = 0;
    int i = 0;
    while (i < charsSize) {
        char currentChar = chars[i];
        int count = 0;
        while (i < charsSize && chars[i] == currentChar) {
            i++;
            count++;
        }
        chars[index++] = currentChar;
        if (count > 1) {
            char temp[10];
            int len = 0;
            while (count > 0) {
                temp[len++] = '0' + (count % 10);
                count /= 10;
            }
            while (len > 0) {
                chars[index++] = temp[--len];
            }
        }
    }
    return index;
}