#include <vector>
#include <numeric>

class Solution {
public:
    long long countCompleteDayPairs(std::vector<int>& hours) {
        long long count = 0;
        std::vector<int> freq(24, 0);

        for (int h : hours) {
            int remainder = h % 24;
            int target_remainder = (24 - remainder) % 24;

            count += freq[target_remainder];
            freq[remainder]++;
        }

        return count;
    }
};