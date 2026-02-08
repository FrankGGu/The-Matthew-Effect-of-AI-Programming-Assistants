#include <string.h> // For memset
#include <stdlib.h> // For MAX macro (or can be written inline)

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int totalFruit(int* fruits, int fruitsSize) {
    // Using a static array for counts. This array needs to be large enough
    // to hold counts for all possible fruit types.
    // The problem states 0 <= fruits[i] < fruits.length, and fruits.length <= 10^5.
    // So, fruit types can range from 0 to 99999. An array of size 100001 is sufficient.
    static int counts[100001]; 

    // Reset the counts array for each test case.
    // This is crucial for LeetCode's testing environment where the function might be called multiple times.
    // We only need to clear up to the maximum possible fruit type encountered in the current test case,
    // but clearing the whole static array is simpler and safe.
    memset(counts, 0, sizeof(counts));

    int left = 0;
    int max_fruits = 0;
    int distinct_types = 0; // Tracks the number of distinct fruit types in the current window

    for (int right = 0; right < fruitsSize; right++) {
        // Add the fruit at the 'right' pointer to the current window
        if (counts[fruits[right]] == 0) {
            // If this fruit type was not in the window, increment distinct_types
            distinct_types++;
        }
        counts[fruits[right]]++; // Increment the count for this fruit type

        // If the window contains more than 2 distinct fruit types,
        // shrink the window from the 'left' until it's valid again.
        while (distinct_types > 2) {
            counts[fruits[left]]--; // Decrement the count for the fruit at 'left'
            if (counts[fruits[left]] == 0) {
                // If the count becomes 0, this fruit type is no longer in the window
                distinct_types--;
            }
            left++; // Move the 'left' pointer to shrink the window
        }

        // After ensuring the window is valid (at most 2 distinct types),
        // calculate the current window size and update max_fruits if it's larger.
        max_fruits = MAX(max_fruits, right - left + 1);
    }

    return max_fruits;
}