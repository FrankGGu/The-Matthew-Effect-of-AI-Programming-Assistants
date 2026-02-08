#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long distributeCandies(int n, int limit) {
    if ((long long)n > 3LL * limit) return 0;
    long long ans = 0;
    for (int i = 0; i <= limit; i++) {
        long long remaining = n - i;
        long long count = limit - (remaining > limit ? remaining - limit : 0);
        count = count > 0 ? count : 0;
        ans += count + 1;
    }
    return ans;
}