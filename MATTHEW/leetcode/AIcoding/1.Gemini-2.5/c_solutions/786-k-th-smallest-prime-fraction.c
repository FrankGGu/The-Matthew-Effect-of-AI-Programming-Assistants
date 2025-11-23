#include <stdlib.h> // For malloc
#include <math.h>   // For fmax

int countFractions(int* arr, int n, double mid, int* out_p, int* out_q) {
    int count = 0;
    *out_p = 0; // Initialize to a fraction smaller than any possible (e.g., 0/1)
    *out_q = 1;

    int j = 1; // Pointer for the denominator (arr[j])
    for (int i = 0; i < n; i++) { // Pointer for the numerator (arr[i])
        // Ensure j is always greater than i (p < q condition)
        // and maintain j's position from the previous iteration of i.
        // fmax ensures j does not go backward relative to its previous value,
        // and also ensures j is at least i+1.
        j = fmax(j, i + 1);

        // For a fixed arr[i], we want to find arr[j] such that arr[i] / arr[j] <= mid.
        // This is equivalent to arr[i] <= mid * arr[j], or arr[j] >= arr[i] / mid.
        // Since arr is sorted, as j increases, arr[j] increases, and arr[i]/arr[j] decreases.
        // We want the smallest j such that arr[i]/arr[j] <= mid.
        // While arr[i]/arr[j] is too large (i.e., > mid), increment j.
        while (j < n && (double)arr[i] > mid * arr[j]) {
            j++;
        }

        // After the loop, if j < n, then arr[i] / arr[j] <= mid.
        // All fractions arr[i] / arr[k] for k from j to n-1 will also be <= mid
        // (because arr[k] >= arr[j]).
        // So, for the current arr[i], there are (n - j) such fractions.
        if (j < n) {
            count += (n - j);
            // Update the largest fraction found so far that is <= mid.
            // Compare arr[i]/arr[j] with *out_p/*out_q using cross-multiplication for precision.
            // Using long long to prevent potential overflow before comparison,
            // though for the given constraints (3*10^4), int might suffice.
            if ((long long)arr[i] * (*out_q) > (long long)*out_p * arr[j]) {
                *out_p = arr[i];
                *out_q = arr[j];
            }
        }
    }
    return count;
}

int* kthSmallestPrimeFraction(int* arr, int arrSize, int k, int* returnSize) {
    double low = 0.0, high = 1.0;
    int ans_p = 0, ans_q = 1; // Stores the k-th smallest fraction

    // Binary search for the fraction value.
    // The loop runs until the interval [low, high] is sufficiently small.
    // 1e-9 is a common precision threshold for double comparisons.
    while (high - low > 1e-9) {
        double mid = low + (high - low) / 2.0; // Calculate midpoint
        int current_p, current_q;

        // Count fractions <= mid and find the largest among them.
        int count = countFractions(arr, arrSize, mid, &current_p, &current_q);

        if (count < k) {
            // If fewer than k fractions are <= mid, then mid is too small.
            // We need to look in the upper half.
            low = mid;
        } else { // count >= k
            // If k or more fractions are <= mid, then mid might be our answer,
            // or the answer is smaller. We try to find a smaller mid.
            // Store the current largest fraction <= mid as a potential answer.
            ans_p = current_p;
            ans_q = current_q;
            high = mid;
        }
    }

    // Allocate memory for the result array [numerator, denominator].
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = ans_p;
    result[1] = ans_q;
    *returnSize = 2; // Set the size of the returned array as required by LeetCode.

    return result;
}