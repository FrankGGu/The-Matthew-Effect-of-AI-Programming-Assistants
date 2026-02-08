#include <stdlib.h> // Required for malloc and abs

int* findClosestElements(int* arr, int arrSize, int k, int x, int* returnSize) {
    // The k closest elements will form a contiguous subarray.
    // We can use binary search to find the starting index of this subarray.
    // The possible starting indices range from 0 to arrSize - k.

    int low = 0;
    int high = arrSize - k;

    while (low < high) {
        int mid = low + (high - low) / 2;

        // We compare arr[mid] and arr[mid+k] relative to x.
        // The goal is to find the leftmost window of k elements.
        // If abs(arr[mid] - x) > abs(arr[mid+k] - x), it means arr[mid] is further
        // from x than arr[mid+k]. In this case, we should shift our window to the right
        // to get closer elements. So, the potential starting index must be greater than mid.
        if (abs(arr[mid] - x) > abs(arr[mid+k] - x)) {
            low = mid + 1;
        } else {
            // abs(arr[mid] - x) <= abs(arr[mid+k] - x)
            // This means arr[mid] is closer to x or equally close (and smaller,
            // which is preferred according to problem rules).
            // So, mid could be the starting index, or we might find an even better
            // starting index to its left. We try to shrink the search space from the right.
            high = mid;
        }
    }

    // After the loop, 'low' will be the starting index of the k closest elements.
    int* result = (int*)malloc(sizeof(int) * k);
    if (result == NULL) {
        *returnSize = 0;
        return NULL; // Handle memory allocation failure
    }

    // Copy the k elements into the result array.
    for (int i = 0; i < k; ++i) {
        result[i] = arr[low + i];
    }

    *returnSize = k;
    return result;
}