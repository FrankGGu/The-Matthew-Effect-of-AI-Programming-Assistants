#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numOfSubarrays(int* arr, int arrSize){
    int even = 1, odd = 0;
    int ans = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] % 2 == 0) {
            even++;
        } else {
            int temp = even;
            even = odd;
            odd = temp + 1;
        }
        ans = (ans + odd) % 1000000007;
    }
    return ans;
}