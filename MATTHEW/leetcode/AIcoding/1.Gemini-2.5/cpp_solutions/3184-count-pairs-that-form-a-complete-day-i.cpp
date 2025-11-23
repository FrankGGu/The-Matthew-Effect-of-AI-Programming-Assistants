#include <vector>

class Solution {
public:
    int countPairs(std::vector<int>& hours) {
        std::vector<int> freq(24, 0);
        long long count = 0;

        for (int hour : hours) {
            int remainder = hour % 24;
            int complement_remainder = (24 - remainder) % 24;

            count += freq[complement_remainder];
            freq[remainder]++;
        }

        return static_cast<int>(count);
    }
};