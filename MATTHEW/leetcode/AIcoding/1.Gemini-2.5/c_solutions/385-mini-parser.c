#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct NestedInteger NestedInteger;

bool NestedInteger_isInteger(NestedInteger* ni);

int NestedInteger_getInteger(NestedInteger* ni);

void NestedInteger_setInteger(NestedInteger* ni, int value);

void NestedInteger_add(NestedInteger* ni, NestedInteger* elem);

NestedInteger* NestedInteger_createInteger(int value);

NestedInteger* NestedInteger_createList();

NestedInteger* deserialize(char* s) {
    if (!s || *s == '\0') {
        return NULL;
    }

    if (s[0] != '[') {
        // It's a single integer
        return NestedInteger_createInteger(atoi(s));
    }

    // Stack for NestedInteger pointers
    NestedInteger** stack = (NestedInteger**)malloc(strlen(s) * sizeof(NestedInteger*));
    int top = -1;

    NestedInteger* current = NULL;
    int i = 0;
    int sign = 1;
    int num = 0;

    while (s[i] != '\0') {
        if (s[i] == '[') {
            NestedInteger* newList = NestedInteger_createList();
            if (current != NULL) {
                NestedInteger_add(current, newList);
            }
            stack[++top] = newList;
            current = newList;
            i++;
        } else if (isdigit(s[i]) || s[i] == '-') {
            sign = 1;
            num = 0;
            if (s[i] == '-') {
                sign = -1;
                i++;
            }
            while (isdigit(s[i])) {
                num = num * 10 + (s[i] - '0');
                i++;
            }
            NestedInteger* newInt = NestedInteger_createInteger(sign * num);
            if (current != NULL) {
                NestedInteger_add(current, newInt);
            } else {
                // This case should only happen if the input is a single integer like "123"
                // but the initial check handles that.
                // If it's a list like "[123]", 'current' would be the list.
                // This branch is mostly for completeness if the initial check was removed.
                free(stack); // Clean up before returning
                return newInt;
            }
            // After parsing a number, we don't increment i here as it's already done in the while loop
            // The outer loop will increment it again, so we need to decrement it once.
            // Or, more cleanly, just continue to the next iteration after parsing the number.
            // No, the while loop condition (s[i]) will handle it.
        } else if (s[i] == ',') {
            i++;
        } else if (s[i] == ']') {
            NestedInteger* result = stack[top--];
            if (top == -1) { // This is the outermost list
                free(stack);
                return result;
            }
            current = stack[top];
            i++;
        } else {
            i++; // Skip other characters like space if any, though problem implies no spaces
        }
    }

    // This part should ideally not be reached if the input is always valid and ends with ']'
    // For single integers, it's handled at the beginning.
    // If it's a list, the last ']' will return the result.
    free(stack);
    return NULL;
}