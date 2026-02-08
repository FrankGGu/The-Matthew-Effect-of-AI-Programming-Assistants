#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distributeCandies(int n, int limit) {
    int count = 0;
    for (int i = 0; i <= limit; i++) {
        if (n - i >= 0 && n - i <= 2 * limit) {
            int remaining = n - i;
            int min_val = (remaining > limit) ? remaining - limit : 0;
            count += limit - min_val + 1;
        }
    }
    return count;
}