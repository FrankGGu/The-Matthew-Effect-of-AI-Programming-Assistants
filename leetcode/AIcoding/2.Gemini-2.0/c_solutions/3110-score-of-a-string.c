#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int scoreOfParentheses(char * s){
    int balance = 0;
    int score = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            balance++;
        } else {
            balance--;
            if (s[i - 1] == '(') {
                score += 1 << balance;
            }
        }
    }

    return score;
}