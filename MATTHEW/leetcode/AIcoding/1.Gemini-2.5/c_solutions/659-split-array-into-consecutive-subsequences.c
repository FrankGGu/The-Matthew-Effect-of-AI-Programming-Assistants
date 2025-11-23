#include <stdbool.h>
#include <string.h> // For memset

#define MAX_ARRAY_IDX 10002
#define ARRAY_SIZE (MAX_ARRAY_IDX + 1)

bool isPossible(int* nums, int numsSize) {
    int freq[ARRAY_SIZE];
    int end_seq[ARRAY_SIZE];

    // Initialize frequency and end_sequence count arrays to zero
    memset(freq, 0, sizeof(freq));
    memset(end_seq, 0, sizeof(end_seq));

    // Populate the frequency array
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    // Iterate through all possible numbers from 1 to 10000 (inclusive)
    // These are the possible values for elements in 'nums'.
    for (int num = 1; num <= 10000; num++) {
        // If there are no occurrences of the current number, skip it
        if (freq[num] == 0) {
            continue;
        }

        // Process all occurrences of 'num'
        while (freq[num] > 0) {
            // Priority 1: Try to extend an existing sequence ending at 'num - 1'
            if (end_seq[num - 1] > 0) {
                end_seq[num - 1]--; // Decrement count of sequences ending at num-1
                end_seq[num]++;     // Increment count of sequences ending at num
                freq[num]--;        // Use one occurrence of num
            }
            // Priority 2: Try to start a new sequence of length 3: (num, num + 1, num + 2)
            // Ensure num + 1 and num + 2 are within array bounds and available
            else if (freq[num + 1] > 0 && freq[num + 2] > 0) {
                freq[num + 1]--;    // Use one occurrence of num + 1
                freq[num + 2]--;    // Use one occurrence of num + 2
                end_seq[num + 2]++; // This new sequence ends at num + 2
                freq[num]--;        // Use one occurrence of num
            }
            // If neither extending nor starting a new sequence is possible,
            // then it's impossible to split the array into valid subsequences.
            else {
                return false;
            }
        }
    }

    // If all numbers were successfully processed, it's possible
    return true;
}