#include <vector>
#include <algorithm>

class Solution {
public:
    long long getMaximumConsecutive(std::vector<int>& coins) {
        std::sort(coins.begin(), coins.end());

        long long reachable = 0; // Represents the maximum value V such that all integers from 0 to V can be formed.

        for (int coin : coins) {
            if (coin > reachable + 1) {
                // If the current coin is greater than reachable + 1,
                // we cannot form reachable + 1.
                // Any subsequent coins will be even larger or equal,
                // so they won't help form reachable + 1 either.
                // Thus, we stop here.
                break;
            }
            // If coin <= reachable + 1, we can extend our range.
            // We can form all values from 0 to reachable.
            // By adding 'coin' to each of these values, we can also form
            // values from 'coin' to 'reachable + coin'.
            // Since 'coin' <= 'reachable + 1', the new range [0, reachable + coin]
            // is fully covered.
            reachable += coin;
        }

        // The number of consecutive values starting from 0 is reachable + 1.
        // For example, if reachable = 0, we can form {0}, which is 1 value.
        // If reachable = 1, we can form {0, 1}, which is 2 values.
        return reachable + 1;
    }
};