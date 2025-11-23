#include <stdio.h>
#include <stdlib.h>
#include <math.h>

bool checkPerfectSquare(long num) {
    long root = sqrt(num);
    return root * root == num;
}

bool judgeSquareSum(int c) {
    for (long a = 0; a <= sqrt(c); a++) {
        long b_squared = c - a * a;
        if (b_squared < 0) continue;
        if (checkPerfectSquare(b_squared)) {
            return true;
        }
    }
    return false;
}