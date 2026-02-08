#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSteps(int num){
    int steps = 0;
    while (num > 0) {
        if (num % 2 == 0) {
            num /= 2;
        } else {
            num -= 1;
        }
        steps++;
    }
    return steps;
}