#include <stdlib.h> // For labs
#include <limits.h> // For LONG_MAX

long long calculateSum(int* arr, int arrSize, int value) {
    long long currentSum = 0;
    for (int i = 0; i < arrSize; i++) {
        currentSum += (arr[i] > value) ? value : arr[i];
    }
    return currentSum;
}

int findBestValue(int* arr, int arrSize, int target) {
    int left = 0;
    // The maximum meaningful value for 'value' is the maximum possible element in arr, which is 10^5.
    // If 'value' is greater than 10^5, then for any arr[i] (which is <= 10^5), the condition arr[i] > value will always be false.
    // This means min(arr[i], value) will always be arr[i].
    // Consequently, calculateSum(arr, arrSize, value) for any value > 10^5 will be constant (equal to the sum of the original array).
    // Therefore, we only need to search for 'value' in the range [0, 100000].
    int right = 100000; 

    int ans_value = 0;
    long long min_diff = LONG_MAX; // Initialize with a very large difference

    // Perform binary search to find the optimal 'value'
    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long currentSum = calculateSum(arr, arrSize, mid);
        long long currentDiff = labs(currentSum - target); // Calculate absolute difference

        // Update the best value found so far
        if (currentDiff < min_diff) {
            min_diff = currentDiff;
            ans_value = mid;
        } else if (currentDiff == min_diff) {
            // If differences are equal, choose the smallest 'value' as per problem statement
            if (mid < ans_value) {
                ans_value = mid;
            }
        }

        // Adjust the search range based on the current sum
        if (currentSum < target) {
            // If the current sum is too small, we need a larger 'value' to increase the sum
            left = mid + 1;
        } else { // currentSum >= target
            // If the current sum is too large or just right, we try a smaller 'value'
            // to get closer to target or find the smallest 'value' that yields min_diff
            right = mid - 1;
        }
    }

    return ans_value;
}