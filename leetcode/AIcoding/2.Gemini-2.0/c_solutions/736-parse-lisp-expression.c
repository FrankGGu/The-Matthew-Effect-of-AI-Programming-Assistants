#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int evaluate(char *expression, int *index, int *vars, int *values, int count) {
    if (expression[*index] == '(') {
        (*index)++;
        if (expression[*index] == 'l') {
            (*index) += 5;
            char var[10];
            int val;
            while (expression[*index] != ')') {
                int i = 0;
                while (expression[*index] != ' ') {
                    var[i++] = expression[(*index)++];
                }
                var[i] = '\0';
                (*index)++;
                val = 0;
                while (expression[*index] != ' ' && expression[*index] != ')') {
                    val = val * 10 + (expression[*index] - '0');
                    (*index)++;
                }
                if (expression[*index] == ' ') (*index)++;
                vars[count] = atoi(var);
                values[count] = val;
                count++;
            }
            (*index)++;
            int result = evaluate(expression, index, vars, values, count);
            (*index)++;
            return result;
        } else if (expression[*index] == 'a') {
            (*index) += 4;
            int val1 = evaluate(expression, index, vars, values, count);
            (*index)++;
            int val2 = evaluate(expression, index, vars, values, count);
            (*index)++;
            return val1 + val2;
        } else {
            (*index) += 5;
            int val1 = evaluate(expression, index, vars, values, count);
            (*index)++;
            int val2 = evaluate(expression, index, vars, values, count);
            (*index)++;
            return val1 * val2;
        }
    } else {
        int num = 0;
        int sign = 1;
        if (expression[*index] == '-') {
            sign = -1;
            (*index)++;
        }
        if (expression[*index] >= '0' && expression[*index] <= '9') {
            while (expression[*index] >= '0' && expression[*index] <= '9') {
                num = num * 10 + (expression[*index] - '0');
                (*index)++;
            }
            return sign * num;
        } else {
            char var[10];
            int i = 0;
            while (expression[*index] >= 'a' && expression[*index] <= 'z') {
                var[i++] = expression[*index];
                (*index)++;
            }
            var[i] = '\0';
            int var_val = atoi(var);
            for (int j = 0; j < count; j++) {
                if (vars[j] == var_val) {
                    return values[j];
                }
            }
            return 0;
        }
    }
}

int evaluate_lisp(char *expression) {
    int index = 0;
    int vars[100];
    int values[100];
    return evaluate(expression, &index, vars, values, 0);
}