#include <string>
#include <algorithm> // Required for std::max

class Solution {
public:
    int secondsToRemoveOccurrences(std::string s) {
        int n = s.length();
        int time = 0;
        int zeros_on_left = 0; // Counts the number of '0's encountered so far

        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                zeros_on_left++;
            } else { // s[i] == '1'
                if (zeros_on_left > 0) {
                    // If there are '0's to the left of the current '1',
                    // these '0's will attempt to move past this '1'.
                    // The time taken is influenced by two factors:
                    // 1. 'time + 1': Represents the time taken if a '0' moves one step to the right.
                    //                This accounts for a '0' moving sequentially past multiple '1's.
                    // 2. 'zeros_on_left': Represents the "queueing" effect. If there are 'zeros_on_left'
                    //                     '0's all trying to pass this '1', it will take at least
                    //                     'zeros_on_left' seconds for all of them to pass this specific '1'.
                    // We take the maximum of these two to find the bottleneck.
                    time = std::max(time + 1, zeros_on_left);

                    // Importantly, 'zeros_on_left' is NOT decremented here.
                    // This is because a '0' that moves past one '1' is still a '0'
                    // that might need to move past subsequent '1's further to its right.
                    // It remains "active" in the count for future '1's.
                }
            }
        }
        return time;
    }
};