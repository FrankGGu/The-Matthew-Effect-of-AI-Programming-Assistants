#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumBuckets(std::string hamsters) {
        int n = hamsters.length();
        int buckets = 0;

        for (int i = 0; i < n; ++i) {
            if (hamsters[i] == 'H') {
                // Check if this hamster is already fed by a bucket to its left
                if (i > 0 && hamsters[i-1] == 'B') {
                    continue; // Already fed
                }

                // Try to place a bucket to the right (most optimal choice)
                if (i + 1 < n && hamsters[i+1] == '.') {
                    buckets++;
                    hamsters[i+1] = 'B'; // Mark as bucket placed
                    // This bucket at i+1 feeds hamsters at i, i+1 (if H), i+2 (if H)
                    // We can skip checking i+1 (now a bucket) and i+2 (potentially fed)
                    // The loop will increment i by 1, so we effectively jump to i+3
                    i += 2; 
                } 
                // If placing to the right is not possible, try to place a bucket to the left
                else if (i > 0 && hamsters[i-1] == '.') {
                    buckets++;
                    hamsters[i-1] = 'B'; // Mark as bucket placed
                    // This bucket at i-1 feeds hamsters at i-2 (if H), i-1 (if B), i (current H)
                    // Current hamster at i is fed, continue to next hamster at i+1
                }
                // If neither left nor right is possible, this hamster cannot be fed
                else {
                    return -1;
                }
            }
        }
        return buckets;
    }
};