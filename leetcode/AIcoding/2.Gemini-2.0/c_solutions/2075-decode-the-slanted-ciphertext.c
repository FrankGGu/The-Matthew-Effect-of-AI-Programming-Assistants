#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * decodeCiphertext(char * encodedText, int rows){
    int len = strlen(encodedText);
    int cols = len / rows;
    char *decoded = (char *)malloc(sizeof(char) * (len + 1));
    int decoded_idx = 0;
    for (int i = 0; i < cols; i++) {
        int row = 0;
        int col = i;
        while (row < rows && col < cols) {
            decoded[decoded_idx++] = encodedText[row * cols + col];
            row++;
            col++;
        }
    }
    decoded[decoded_idx] = '\0';
    while (decoded_idx > 0 && decoded[decoded_idx - 1] == ' ') {
        decoded[--decoded_idx] = '\0';
    }
    return decoded;
}