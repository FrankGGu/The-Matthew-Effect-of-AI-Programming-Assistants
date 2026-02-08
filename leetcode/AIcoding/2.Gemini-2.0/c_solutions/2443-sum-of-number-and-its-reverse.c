#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool sumOfNumberAndReverse(int num){
    for (int i = 0; i <= num; i++) {
        int reversed = 0;
        int temp = i;
        while (temp > 0) {
            reversed = reversed * 10 + temp % 10;
            temp /= 10;
        }
        if (i + reversed == num) {
            return true;
        }
    }
    return false;
}