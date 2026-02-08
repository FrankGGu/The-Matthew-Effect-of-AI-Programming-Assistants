#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* helloLeetCode() {
    char* result = (char*)malloc(14 * sizeof(char));
    strcpy(result, "Hello LeetCode!");
    return result;
}