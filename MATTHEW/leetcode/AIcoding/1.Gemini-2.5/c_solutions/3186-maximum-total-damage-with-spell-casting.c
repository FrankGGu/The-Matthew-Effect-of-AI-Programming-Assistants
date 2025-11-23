#include <stdlib.h>
#include <math.h> // For fmax

long long maximumTotalDamage(int* damage, int damageSize) {
    if (damageSize == 0) {
        return 0;
    }

    int max_val = 0;
    for (int i = 0; i < damageSize; i++) {
        if (damage[i] > max_val) {
            max_val = damage[i];
        }
    }

    long long* counts = (long long*)calloc(max_val + 1, sizeof(long long));
    if (counts == NULL) {
        return 0; 
    }

    for (int i = 0; i < damageSize; i++) {
        counts[damage[i]] += damage[i];
    }

    long long prev2 = 0; 
    long long prev1 = 0; 
    long long current = 0;

    if (max_val >= 1) {
        prev1 = counts[1];
    }

    for (int i = 2; i <= max_val; i++) {
        current = fmax(prev1, prev2 + counts[i]);
        prev2 = prev1;
        prev1 = current;
    }

    long long result = prev1; 

    free(counts);

    return result;
}