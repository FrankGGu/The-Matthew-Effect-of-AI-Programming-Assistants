#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeValid(char * s, char * locked) {
    int n = strlen(s);
    if (n % 2 != 0) {
        return false;
    }

    int balance = 0, wildcard = 0;
    for (int i = 0; i < n; i++) {
        if (locked[i] == '1') {
            if (s[i] == '(') {
                balance++;
            } else {
                balance--;
            }
        } else {
            wildcard++;
        }

        if (balance + wildcard < 0) {
            return false;
        }
    }

    balance = 0;
    wildcard = 0;
    for (int i = n - 1; i >= 0; i--) {
        if (locked[i] == '1') {
            if (s[i] == ')') {
                balance++;
            } else {
                balance--;
            }
        } else {
            wildcard++;
        }

        if (balance + wildcard < 0) {
            return false;
        }
    }

    return true;
}