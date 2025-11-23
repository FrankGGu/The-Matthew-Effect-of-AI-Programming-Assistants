#include <stdio.h>
#include <stdlib.h>

int minAddToMakeValid(char * s) {
    int balance = 0;
    int add = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '(') {
            balance++;
        } else {
            balance--;
            if (balance < 0) {
                add++;
                balance = 0;
            }
        }
    }
    return add + balance;
}