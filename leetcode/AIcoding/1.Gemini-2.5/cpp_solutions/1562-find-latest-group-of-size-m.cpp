#include <vector>
#include <numeric>

class Solution {
public:
    int findLatestStep(std::vector<int>& arr, int m) {
        int n = arr.size();

        // state[i] = 0 if bit i is 0, 1 if bit i is 1.
        // Using 0-indexed positions for state and length arrays.
        std::vector<int> state(n, 0);

        // length[i] stores the length of the group of 1s if i is an endpoint of a group.
        // If i is the start of a group, length[i] stores its length.
        // If i is the end of a group, length[i] stores its length.
        std::vector<int> length(n, 0);

        // counts[s] stores the number of groups of size s.
        // Max group size can be n.
        std::vector<int> counts(n + 1, 0);

        int ans = -1;

        for (int i = 0; i < n; ++i) {
            int pos = arr[i] - 1; // Convert 1-indexed value from arr to 0-indexed position

            int left_len = 0;
            // Check if there's a group of 1s to the left
            if (pos > 0 && state[pos - 1] == 1) {
                left_len = length[pos - 1]; // length[pos-1] stores the length of the group ending at pos-1
            }

            int right_len = 0;
            // Check if there's a group of 1s to the right
            if (pos < n - 1 && state[pos + 1] == 1) {
                right_len = length[pos + 1]; // length[pos+1] stores the length of the group starting at pos+1
            }

            // Mark current position as 1
            state[pos] = 1;

            // Calculate the new length of the merged group
            int new_len = 1 + left_len + right_len;

            // Update counts for old groups that are now merging
            if (left_len > 0) {
                counts[left_len]--;
            }
            if (right_len > 0) {
                counts[right_len]--;
            }

            // Update count for the new merged group
            counts[new_len]++;

            // Update lengths at the new boundaries of the merged group
            // The new group starts at (pos - left_len)
            // The new group ends at (pos + right_len)
            length[pos - left_len] = new_len; 
            length[pos + right_len] = new_len; 

            // If there is at least one group of size m, update the answer
            if (counts[m] > 0) {
                ans = i + 1; // Store the current step (1-indexed)
            }
        }

        return ans;
    }
};