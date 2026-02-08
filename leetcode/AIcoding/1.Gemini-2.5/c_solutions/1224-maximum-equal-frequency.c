#include <string.h> // For memset

#define MAX_NUM_VAL 100000
#define MAX_N 100000

static int counts[MAX_NUM_VAL + 1];
static int freq_counts[MAX_N + 1];

int maxEqualFreq(int* nums, int numsSize) {
    // Initialize arrays to zero for each test case
    // Using static arrays ensures they are zero-initialized once,
    // but for LeetCode multiple test cases, they need re-initialization.
    // memset is efficient for this.
    memset(counts, 0, sizeof(counts));
    memset(freq_counts, 0, sizeof(freq_counts));

    int max_freq = 0;           // Maximum frequency encountered so far
    int distinct_elements = 0;  // Number of distinct elements in the current prefix
    int ans = 0;                // Stores the maximum valid prefix length

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int current_length = i + 1;

        // Get old and new frequencies for the current number
        int old_freq = counts[num];
        int new_freq = old_freq + 1;

        // Update freq_counts for the old frequency
        if (old_freq > 0) {
            freq_counts[old_freq]--;
        } else {
            // This is the first time we've seen this number in the prefix
            distinct_elements++;
        }

        // Update counts for the current number and freq_counts for the new frequency
        counts[num] = new_freq;
        freq_counts[new_freq]++;

        // Update the overall maximum frequency
        if (new_freq > max_freq) {
            max_freq = new_freq;
        }

        // Check conditions for a valid prefix:
        // A prefix is valid if, after removing exactly one element, all remaining elements have the same frequency.

        // Condition 1: All elements in the prefix appear exactly once. (e.g., [1,2,3])
        // If max_freq is 1, it means all distinct elements appear once.
        // Removing any one element leaves all others still appearing once.
        if (max_freq == 1) {
            ans = current_length;
        }
        // Condition 2: All elements in the prefix have frequency 'k', except one element which has frequency 'k+1'.
        // (e.g., [1,1,1,2,2] -> remove one '1' -> [1,1,2,2], all freq 2)
        // This implies:
        //   - Only one number appears 'max_freq' times (freq_counts[max_freq] == 1).
        //   - All other 'distinct_elements - 1' numbers must appear 'max_freq - 1' times.
        //   - The total length current_length must be:
        //     (1 * max_freq) + ((distinct_elements - 1) * (max_freq - 1))
        else if (freq_counts[max_freq] == 1 &&
                   (max_freq + (distinct_elements - 1) * (max_freq - 1)) == current_length) {
            ans = current_length;
        }
        // Condition 3: All elements in the prefix have frequency 'k', except one element which has frequency '1'.
        // (e.g., [1,1,2,2,3] -> remove '3' -> [1,1,2,2], all freq 2)
        // This implies:
        //   - Only one number appears 1 time (freq_counts[1] == 1).
        //   - All other 'distinct_elements - 1' numbers must appear 'max_freq' times.
        //   - The total length current_length must be:
        //     (1 * 1) + ((distinct_elements - 1) * max_freq)
        else if (freq_counts[1] == 1 &&
                   (1 + (distinct_elements - 1) * max_freq) == current_length) {
            ans = current_length;
        }
        // Condition 4: There is only one distinct element in the prefix. (e.g., [2,2,2])
        // If there's only one distinct element, its frequency is 'current_length'.
        // Removing one instance leaves 'current_length - 1' instances, all with frequency 'current_length - 1'.
        // This is always valid.
        else if (distinct_elements == 1) {
            ans = current_length;
        }
    }

    return ans;
}