#include <vector>
#include <map>
#include <cmath>
#include <algorithm>

class Solution {
public:
    bool canReorderDoubled(std::vector<int>& arr) {
        std::map<int, int> counts;
        for (int x : arr) {
            counts[x]++;
        }

        for (auto& pair : counts) {
            int x = pair.first;
            int x_freq = pair.second;

            if (x_freq == 0) {
                continue; // This number has already been used up as part of a pair
            }

            // Special case for 0: it must pair with another 0.
            // So, the count of 0s must be even.
            if (x == 0) {
                if (x_freq % 2 != 0) {
                    return false;
                }
                pair.second = 0; // Mark 0s as used
                continue;
            }

            int target;
            if (x < 0) {
                // If x is negative, and we are processing in increasing order (from std::map),
                // x must be the larger number in a (target, x) pair.
                // So, we need to find target = x / 2.
                // x must be even to be a doubled value of an integer.
                if (x % 2 != 0) {
                    return false;
                }
                target = x / 2;
            } else { // x > 0
                // If x is positive, it must be the smaller number in an (x, target) pair.
                // So, we need to find target = 2 * x.
                target = 2 * x;
            }

            // Check if the target exists in the map and has enough frequency.
            // Since std::map iterates keys in increasing order, 'target' (which is always
            // numerically greater than 'x' for both x<0 and x>0) will be processed later.
            // Thus, counts[target] will reflect its true current frequency.
            auto it_target = counts.find(target);
            if (it_target == counts.end() || it_target->second < x_freq) {
                return false;
            }

            // Decrement the frequencies for both x and target
            it_target->second -= x_freq;
            pair.second = 0; // Mark x as fully used
        }

        return true;
    }
};