#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int maximumEnemyForts(std::vector<int>& forts) {
        int max_captured = 0;
        int current_start_index = -1; 

        for (int i = 0; i < forts.size(); ++i) {
            if (forts[i] == 0) {
                continue;
            }

            // We've encountered a non-empty fort (1 or -1)
            if (current_start_index != -1) {
                // If we have a previous non-empty fort
                if (forts[i] != forts[current_start_index]) {
                    // If the current fort is of a different type than the start fort,
                    // we potentially found a capture scenario.
                    // The number of empty forts between them is i - current_start_index - 1.
                    max_captured = std::max(max_captured, i - current_start_index - 1);
                }
            }

            // The current fort becomes the new potential starting fort for the next capture.
            current_start_index = i;
        }

        return max_captured;
    }
};