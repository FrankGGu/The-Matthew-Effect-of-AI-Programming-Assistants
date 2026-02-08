#include <stdio.h>
#include <stdlib.h>

int reverseNumber(int num) {
    int reversed = 0;
    while (num > 0) {
        reversed = reversed * 10 + num % 10;
        num /= 10;
    }
    return reversed;
}

int isNumberAfterDoubleReversal(int num) {
    int firstReverse = reverseNumber(num);
    int secondReverse = reverseNumber(firstReverse);
    return secondReverse == num;
}