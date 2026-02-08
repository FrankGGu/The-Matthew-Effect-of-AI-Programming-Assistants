#include <math.h>

int pivotInteger(int n) {
    int sum_1_to_n = n * (n + 1) / 2;

    // The condition for a pivot integer x is:
    // sum(1 to x) == sum(x to n)
    // We know sum(1 to x) = x * (x + 1) / 2
    // And sum(x to n) = sum(1 to n) - sum(1 to x-1)
    // So, x * (x + 1) / 2 = n * (n + 1) / 2 - (x - 1) * x / 2
    // Multiplying by 2:
    // x * (x + 1) = n * (n + 1) - (x - 1) * x
    // x^2 + x = n^2 + n - (x^2 - x)
    // x^2 + x = n^2 + n - x^2 + x
    // 2 * x^2 = n^2 + n
    // 2 * x^2 = n * (n + 1)
    // x^2 = n * (n + 1) / 2

    // Thus, we need to find an integer x such that x*x equals sum_1_to_n.
    // This implies that sum_1_to_n must be a perfect square.

    int x_candidate = (int)sqrt(sum_1_to_n);

    if (x_candidate * x_candidate == sum_1_to_n) {
        return x_candidate;
    } else {
        return -1;
    }
}