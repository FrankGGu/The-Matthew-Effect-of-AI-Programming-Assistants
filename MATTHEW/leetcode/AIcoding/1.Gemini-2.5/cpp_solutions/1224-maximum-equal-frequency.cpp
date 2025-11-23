#include <vector>
#include <unordered_map>
#include <algorithm> // For std::max

class Solution {
public:
    int maxEqualFreq(std::vector<int>& nums) {
        std::unordered_map<int, int> freq;       // Stores frequency of each number (number -> frequency)
        std::unordered_map<int, int> freq_count; // Stores count of numbers having a certain frequency (frequency -> count of numbers)
        int max_f = 0;                           // Maximum frequency observed among all numbers so far
        int ans = 0;                             // Maximum length of prefix satisfying the condition

        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            int current_len = i + 1;

            // Update freq_count for the old frequency of 'num'
            if (freq[num] > 0) {
                freq_count[freq[num]]--;
                if (freq_count[freq[num]] == 0) {
                    freq_count.erase(freq[num]);
                }
            }

            // Increment frequency of current number 'num'
            freq[num]++;

            // Update freq_count for the new frequency of 'num'
            freq_count[freq[num]]++;

            // Update max_f
            max_f = std::max(max_f, freq[num]);

            // Check if the current prefix (of length current_len) satisfies the condition
            bool current_prefix_is_valid = false;

            // Condition 1: All elements in the prefix appear exactly once. (e.g., [1,2,3])
            // If max_f is 1, it means all elements must have frequency 1.
            if (max_f == 1) {
                current_prefix_is_valid = true;
            }
            // Condition 2: Only one distinct element in the prefix, it appears max_f times. (e.g., [1,1,1])
            // This means freq_count has only one entry (max_f -> 1), indicating one number appears max_f times.
            else if (freq_count.size() == 1 && freq_count.begin()->first == max_f && freq_count.begin()->second == 1) {
                current_prefix_is_valid = true;
            }
            // Condition 3: There are exactly two distinct frequencies in the prefix.
            else if (freq_count.size() == 2) {
                // Case 3a: One element appears max_f times, and all other elements appear max_f-1 times. (e.g., [1,1,2,2,2])
                // If we remove the single element with frequency max_f, all remaining elements will have frequency max_f-1.
                if (freq_count.count(max_f) && freq_count[max_f] == 1 && 
                    freq_count.count(max_f - 1) && (max_f - 1) * freq_count[max_f - 1] == current_len - max_f) {
                    current_prefix_is_valid = true;
                }
                // Case 3b: One element appears once, and all other elements appear max_f times. (e.g., [1,1,2,2,3])
                // If we remove the single element with frequency 1, all remaining elements will have frequency max_f.
                else if (freq_count.count(1) && freq_count[1] == 1 && 
                         freq_count.count(max_f) && max_f * freq_count[max_f] == current_len - 1) {
                    current_prefix_is_valid = true;
                }
            }

            if (current_prefix_is_valid) {
                ans = current_len;
            }
        }

        return ans;
    }
};