#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSteps(char * s){
    int steps = 0;
    int carry = 0;
    int len = strlen(s);
    for (int i = len - 1; i > 0; i--) {
        if (s[i] - '0' + carry == 1) {
            steps++;
            carry = 1;
        } else {
            steps++;
        }
    }
    steps += carry;
    return steps;
}