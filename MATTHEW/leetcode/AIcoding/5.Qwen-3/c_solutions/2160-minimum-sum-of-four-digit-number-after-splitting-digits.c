#include <stdio.h>
#include <stdlib.h>

int number(int *digits, int size) {
    int num = 0;
    for (int i = 0; i < size; i++) {
        num = num * 10 + digits[i];
    }
    return num;
}

int minimumSum(int num) {
    int digits[4];
    for (int i = 0; i < 4; i++) {
        digits[i] = num % 10;
        num /= 10;
    }
    for (int i = 0; i < 4; i++) {
        for (int j = i + 1; j < 4; j++) {
            if (digits[i] > digits[j]) {
                int temp = digits[i];
                digits[i] = digits[j];
                digits[j] = temp;
            }
        }
    }
    return number(digits, 2) + number(digits + 2, 2);
}