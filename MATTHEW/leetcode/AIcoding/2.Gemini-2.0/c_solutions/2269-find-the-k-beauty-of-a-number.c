#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int divisor(int num, int k) {
    int temp = num;
    int divisor = 0;
    int count = 0;

    if (k > 0) {
        int pow10 = 1;
        for (int i = 1; i < k; i++) {
            pow10 *= 10;
        }

        for (int i = 0; temp > 0; i++) {
            int subNum = temp % pow10;
            if (subNum != 0 && num % subNum == 0) {
                count++;
            }
            temp /= 10;
        }
    }
    return count;
}