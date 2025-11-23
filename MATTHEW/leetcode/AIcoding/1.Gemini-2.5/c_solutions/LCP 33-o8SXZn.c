#include <stdio.h>
#include <stdlib.h> // For max
#include <limits.h> // For LLONG_MAX

long long custom_max(long long a, long long b) {
    return a > b ? a : b;
}

long long custom_min(long long a, long long b) {
    return a < b ? a : b;
}

int storeWater(int* bucket, int bucketSize, int* vat, int vatSize) {
    long long total_min_cost = 0;

    // MAX_K_ITER is the upper bound for the number of pour operations (k) we consider for each vat.
    // The optimal k for a single vat is bounded.
    // If bucket[i] is small (e.g., 0), the cost is C + V/C, minimized around C = sqrt(V).
    // So k is around sqrt(V). For V_max = 10^9, sqrt(V_max) is ~31622.
    // If bucket[i] is large, the cost is max(0, C - B) + k.
    // If C - B < 0, cost is k. The minimum k is ceil(V/B).
    // If C - B >= 0, cost is C - B + k. This is also minimized around C = sqrt(V).
    // The maximum of these optimal k values is typically bounded by a constant like 100,000 or 200,000.
    // This value ensures that all relevant k values are checked.
    // For example, if k > 100,000, then ceil(vat[i]/k) is at most 10^9/10^5 = 10^4.
    // If bucket[i] is large (e.g., >= 10^4), then ceil(vat[i]/k) - bucket[i] is negative, so cost is k.
    // The minimum k for this scenario is ceil(vat[i]/bucket[i]), which would be <= 10^9/10^4 = 10^5.
    // This is within the MAX_K_ITER range.
    // If bucket[i] is small (e.g., < 10^4), then the cost is ceil(vat[i]/k) - bucket[i] + k.
    // The minimum of this is around 2*sqrt(vat[i]), which is ~63245 for vat[i]=10^9.
    // This is also within the MAX_K_ITER range.
    // Therefore, iterating k up to MAX_K_ITER is sufficient.
    const int MAX_K_ITER = 100000; 

    for (int i = 0; i < bucketSize; ++i) {
        if (vat[i] == 0) {
            continue;
        }

        long long min_cost_for_vat_i = LLONG_MAX;

        for (long long k = 1; k <= MAX_K_ITER; ++k) {
            long long required_capacity = (vat[i] + k - 1) / k; // Equivalent to ceil(vat[i] / k)
            long long capacity_increase_cost = custom_max(0LL, required_capacity - bucket[i]);
            long long current_vat_cost = capacity_increase_cost + k;
            min_cost_for_vat_i = custom_min(min_cost_for_vat_i, current_vat_cost);
        }
        total_min_cost += min_cost_for_vat_i;
    }

    return (int)total_min_cost;
}