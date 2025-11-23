#include <vector>
#include <numeric>

class Solution {
public:
    int numPairsDivisibleBy60(std::vector<int>& time) {
        std::vector<int> counts(60, 0);
        int pairs = 0;

        for (int t : time) {
            int remainder = t % 60;
            int complement_remainder = (60 - remainder) % 60;

            pairs += counts[complement_remainder];
            counts[remainder]++;
        }

        return pairs;
    }
};