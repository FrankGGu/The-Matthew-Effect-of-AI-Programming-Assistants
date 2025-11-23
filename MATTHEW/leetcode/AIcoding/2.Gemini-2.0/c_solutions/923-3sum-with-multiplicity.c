#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int threeSumMulti(int* arr, int arrSize, int target) {
    long long count = 0;
    int mod = 1000000007;
    int freq[101] = {0};

    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }

    for (int i = 0; i <= 100; i++) {
        for (int j = i; j <= 100; j++) {
            int k = target - i - j;
            if (k < 0 || k > 100) continue;

            if (i == j && j == k) {
                count = (count + ((long long)freq[i] * (freq[i] - 1) * (freq[i] - 2) / 6)) % mod;
            } else if (i == j && j != k) {
                count = (count + ((long long)freq[i] * (freq[i] - 1) / 2 * freq[k])) % mod;
            } else if (i < j && j < k) {
                count = (count + ((long long)freq[i] * freq[j] * freq[k])) % mod;
            }
        }
    }

    return (int)count;
}