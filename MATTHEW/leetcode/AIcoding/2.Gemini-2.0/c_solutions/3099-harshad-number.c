#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isHarshad(int n) {
    int sum = 0;
    int temp = n;
    while (temp > 0) {
        sum += temp % 10;
        temp /= 10;
    }
    return (sum != 0 && n % sum == 0);
}