#include <string.h>
#include <ctype.h>

int calculate(char *s) {
    int len = strlen(s);
    int current_num = 0;
    int sum = 0;
    int last_val = 0; 
    char last_op = '+';

    for (int i = 0; i < len; ++i) {
        char c = s[i];

        if (isdigit(c)) {
            current_num = current_num * 10 + (c - '0');
        }

        if ((!isdigit(c) && c != ' ') || i == len - 1) {
            if (last_op == '+') {
                sum += last_val;
                last_val = current_num;
            } else if (last_op == '-') {
                sum += last_val;
                last_val = -current_num;
            } else if (last_op == '*') {
                last_val *= current_num;
            } else if (last_op == '/') {
                last_val /= current_num;
            }
            last_op = c;
            current_num = 0;
        }
    }
    sum += last_val;
    return sum;
}