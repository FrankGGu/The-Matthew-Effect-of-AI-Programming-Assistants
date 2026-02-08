#include <stdio.h>
#include <stdlib.h>

int sumImbalanceNumbers(int* arr, int n) {
    int result = 0;
    for (int i = 0; i < n; i++) {
        int max_val = arr[i];
        int min_val = arr[i];
        int balance = 0;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] > max_val) {
                max_val = arr[j];
                balance++;
            } else if (arr[j] < min_val) {
                min_val = arr[j];
                balance++;
            } else {
                balance += 1;
            }
            result += balance;
        }
    }
    return result;
}