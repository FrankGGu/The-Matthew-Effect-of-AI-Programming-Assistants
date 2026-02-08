#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* faultyKeyboard(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == 'a') {
            result[index++] = 'a';
        } else if (s[i] == 'b') {
            result[index++] = 'b';
        } else if (s[i] == 'c') {
            result[index++] = 'c';
        } else if (s[i] == 'd') {
            result[index++] = 'd';
        } else if (s[i] == 'e') {
            result[index++] = 'e';
        } else if (s[i] == 'f') {
            result[index++] = 'f';
        } else if (s[i] == 'g') {
            result[index++] = 'g';
        } else if (s[i] == 'h') {
            result[index++] = 'h';
        } else if (s[i] == 'i') {
            result[index++] = 'i';
        } else if (s[i] == 'j') {
            result[index++] = 'j';
        } else if (s[i] == 'k') {
            result[index++] = 'k';
        } else if (s[i] == 'l') {
            result[index++] = 'l';
        } else if (s[i] == 'm') {
            result[index++] = 'm';
        } else if (s[i] == 'n') {
            result[index++] = 'n';
        } else if (s[i] == 'o') {
            result[index++] = 'o';
        } else if (s[i] == 'p') {
            result[index++] = 'p';
        } else if (s[i] == 'q') {
            result[index++] = 'q';
        } else if (s[i] == 'r') {
            result[index++] = 'r';
        } else if (s[i] == 's') {
            result[index++] = 's';
        } else if (s[i] == 't') {
            result[index++] = 't';
        } else if (s[i] == 'u') {
            result[index++] = 'u';
        } else if (s[i] == 'v') {
            result[index++] = 'v';
        } else if (s[i] == 'w') {
            result[index++] = 'w';
        } else if (s[i] == 'x') {
            result[index++] = 'x';
        } else if (s[i] == 'y') {
            result[index++] = 'y';
        } else if (s[i] == 'z') {
            result[index++] = 'z';
        }
    }

    result[index] = '\0';
    return result;
}