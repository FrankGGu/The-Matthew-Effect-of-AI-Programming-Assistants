#include <string.h>
#include <stdlib.h>

int scoreOfParentheses(char * s) {
    int* stack = (int*)malloc(sizeof(int) * (strlen(s) / 2 + 1));
    int top = -1;
    int score = 0;

    for (int i = 0; i < strlen(s); i++) {
        if (s[i] == '(') {
            stack[++top] = score;
            score = 0;
        } else {
            score = stack[top] + (score == 0 ? 1 : 2 * score);
            top--;
        }
    }

    free(stack);
    return score;
}