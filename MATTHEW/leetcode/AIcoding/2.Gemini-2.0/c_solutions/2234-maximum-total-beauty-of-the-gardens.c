#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximumBeauty(int gardens[], int n, long long newFlowers, int target, int full, int partial) {
    long long sum = 0;
    for (int i = 0; i < n; i++) {
        sum += gardens[i];
    }

    qsort(gardens, n, sizeof(int), cmpfunc);

    long long ans = 0;
    for (int i = 0; i <= n; i++) {
        long long curFlowers = newFlowers;
        long long curAns = (long long)i * full;

        for (int j = n - i; j < n; j++) {
            curFlowers -= target - gardens[j];
        }

        if (curFlowers < 0) {
            break;
        }

        long long l = 0, r = target - 1;
        long long best = 0;

        if (n - i > 0) {
            while (l <= r) {
                long long mid = l + (r - l) / 2;
                long long need = 0;
                for (int j = 0; j < n - i; j++) {
                    need += (mid > gardens[j] ? mid - gardens[j] : 0);
                }

                if (need <= curFlowers) {
                    best = mid;
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }

            curAns += best * partial;
        }

        ans = (ans > curAns) ? ans : curAns;
    }

    return ans;
}

int cmpfunc(const void *a, const void *b) {
   return ( *(int*)a - *(int*)b );
}