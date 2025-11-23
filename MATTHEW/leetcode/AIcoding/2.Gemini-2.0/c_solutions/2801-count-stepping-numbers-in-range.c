#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSteppingNumbers(int low, int high) {
    int count = 0;

    long long queue[100000];
    int head = 0;
    int tail = 0;

    for (int i = 1; i <= 9; i++) {
        queue[tail++] = i;
    }

    while (head < tail) {
        long long num = queue[head++];

        if (num >= low && num <= high) {
            count++;
        }

        if (num > high) {
            continue;
        }

        int lastDigit = num % 10;

        if (lastDigit > 0) {
            long long nextNum = num * 10 + (lastDigit - 1);
            if(nextNum <= high)
                queue[tail++] = nextNum;
        }

        if (lastDigit < 9) {
            long long nextNum = num * 10 + (lastDigit + 1);
             if(nextNum <= high)
                 queue[tail++] = nextNum;
        }
    }

    if (low == 0) {
        count++;
    }

    return count;
}