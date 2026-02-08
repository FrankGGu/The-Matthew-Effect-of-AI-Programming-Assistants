#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int maxNumber(int k) {
    int result = 0;
    int price = 0;
    int i = 1;
    while (price <= k) {
        int temp = i;
        int p = 0;
        while (temp > 0) {
            if (temp % 10 == 0) p++;
            temp /= 10;
        }
        price += p;
        if (price > k) break;
        result = i;
        i++;
    }
    return result;
}