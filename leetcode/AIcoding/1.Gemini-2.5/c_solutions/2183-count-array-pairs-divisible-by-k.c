#include <stdlib.h>
#include <math.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int freq_gcd[100001];

long long countPairs(int* nums, int numsSize, int k) {
    // Clear the frequency array for the current test case.
    // This is crucial for LeetCode's multiple test case environment.
    memset(freq_gcd, 0, sizeof(freq_gcd));

    // Store all divisors of k.
    // The maximum number of divisors for k <= 10^5 is 128 (e.g., for k=75600).
    // Allocate enough space, e.g., 200 elements.
    int* divisors = (int*)malloc(200 * sizeof(int));
    int divisors_count = 0;

    for (int i = 1; i * i <= k; ++i) {
        if (k % i == 0) {
            divisors[divisors_count++] = i;
            if (i * i != k) {
                divisors[divisors_count++] = k / i;
            }
        }
    }

    long long ans = 0;

    // Iterate through each number in the input array.
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];

        // Calculate the GCD of the current number and k.
        int g_num = gcd(num, k);

        // Iterate through all previously encountered GCD values (which are divisors of k).
        // For each such divisor 'd', check if (g_num * d) is a multiple of k.
        // If it is, then any number 'x' previously encountered such that gcd(x, k) = d
        // will form a valid pair with the current 'num'.
        for (int j = 0; j < divisors_count; ++j) {
            int d = divisors[j];
            if (freq_gcd[d] > 0) {
                // The condition (nums[i] * nums[j]) % k == 0 is equivalent to
                // (gcd(nums[i], k) * gcd(nums[j], k)) % k == 0.
                // Use 1LL for multiplication to prevent potential overflow before modulo.
                if ((1LL * g_num * d) % k == 0) {
                    ans += freq_gcd[d];
                }
            }
        }

        // Increment the frequency count for the current number's GCD with k.
        freq_gcd[g_num]++;
    }

    // Free the dynamically allocated memory for divisors.
    free(divisors); 

    return ans;
}