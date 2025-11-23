#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool verifyPreorder(char* preorder) {
    int capacity = 100;
    int* stack = (int*)malloc(capacity * sizeof(int));
    int top = -1;
    char* token = strtok(preorder, ",");
    while (token != NULL) {
        if (top >= 0 && strcmp(token, "null") != 0) {
            if (top + 1 >= capacity) {
                capacity *= 2;
                stack = (int*)realloc(stack, capacity * sizeof(int));
            }
            stack[++top] = 1;
        } else {
            if (top >= 0) {
                top--;
            } else {
                free(stack);
                return false;
            }
        }
        token = strtok(NULL, ",");
    }
    free(stack);
    return top == -1;
}