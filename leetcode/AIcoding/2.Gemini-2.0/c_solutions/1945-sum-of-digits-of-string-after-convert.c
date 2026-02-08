#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int getLucky(char * s, int k){
    int num = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        num += s[i] - 'a' + 1;
    }

    int sum = num;
    for (int i = 1; i < k; i++) {
        sum = getSum(sum);
    }
    return sum;
}