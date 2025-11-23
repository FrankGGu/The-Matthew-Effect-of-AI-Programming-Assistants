#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calculate(char* expr) {
    int stack[1000], top = -1, num = 0, res = 0, sign = 1;
    for (int i = 0; expr[i]; i++) {
        if (isdigit(expr[i])) {
            num = num * 10 + (expr[i] - '0');
        } else if (expr[i] == '+') {
            res += sign * num;
            num = 0;
            sign = 1;
        } else if (expr[i] == '-') {
            res += sign * num;
            num = 0;
            sign = -1;
        } else if (expr[i] == '(') {
            stack[++top] = res;
            stack[++top] = sign;
            res = 0;
            sign = 1;
        } else if (expr[i] == ')') {
            res += sign * num;
            num = 0;
            res *= stack[top--];
            res += stack[top--];
        }
    }
    return res + sign * num;
}

int scoreOfStudents(char* s, int* answers, int answersSize) {
    int correctAnswer = calculate(s);
    int cnt = 0;
    for (int i = 0; i < answersSize; i++) {
        if (answers[i] == correctAnswer) {
            cnt += 5;
        } else if (abs(answers[i] - correctAnswer) == 1) {
            cnt += 2;
        } else if (answers[i] > 0 && (calculate(s) == answers[i] || abs(answers[i] - correctAnswer) <= 1)) {
            cnt += 1;
        }
    }
    return cnt;
}