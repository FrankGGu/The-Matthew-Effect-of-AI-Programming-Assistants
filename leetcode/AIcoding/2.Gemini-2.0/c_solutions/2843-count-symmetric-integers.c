#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSymmetricIntegers(int low, int high) {
    int count = 0;
    for (int i = low; i <= high; i++) {
        int num = i;
        int digits = 0;
        int arr[5] = {0};
        while (num > 0) {
            arr[digits++] = num % 10;
            num /= 10;
        }
        if (digits % 2 == 0) {
            int sum1 = 0;
            int sum2 = 0;
            for (int j = 0; j < digits / 2; j++) {
                sum1 += arr[j];
            }
            for (int j = digits / 2; j < digits; j++) {
                sum2 += arr[j];
            }
            if (sum1 == sum2) {
                count++;
            }
        }
    }
    return count;
}