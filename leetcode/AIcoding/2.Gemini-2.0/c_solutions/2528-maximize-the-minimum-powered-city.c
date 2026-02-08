#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxPower(int* stations, int stationsSize, int r, int k) {
    long long left = 0;
    long long right = 0;
    for (int i = 0; i < stationsSize; i++) {
        right += stations[i];
    }
    right += k;

    long long ans = 0;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long need = 0;
        long long sum = 0;
        int* add = (int*)malloc(sizeof(int) * stationsSize);
        for (int i = 0; i < stationsSize; i++) {
            add[i] = 0;
        }

        for (int i = 0; i < stationsSize; i++) {
            sum += (i > 0 ? add[i - 1] : 0);
            long long current = stations[i] + sum;
            if (current < mid) {
                need += mid - current;
                add[i] = mid - current;
                sum += add[i];
                if (i + 2 * r < stationsSize) {
                    add[i + 2 * r] = -add[i];
                }
            }
        }

        free(add);

        if (need <= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}