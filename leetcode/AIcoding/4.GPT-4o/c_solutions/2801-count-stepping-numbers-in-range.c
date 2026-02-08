#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSteppingNumbers(char* low, char* high) {
    int lowNum = atoi(low);
    int highNum = atoi(high);
    int count = 0;

    for (int i = 0; i <= 9; i++) {
        count += dfs(i, lowNum, highNum);
    }

    return count;
}

int dfs(int num, int low, int high) {
    if (num > high) return 0;
    if (num >= low) return 1;

    int count = 0;
    int lastDigit = num % 10;

    if (lastDigit > 0) {
        count += dfs(num * 10 + (lastDigit - 1), low, high);
    }
    if (lastDigit < 9) {
        count += dfs(num * 10 + (lastDigit + 1), low, high);
    }

    return count;
}