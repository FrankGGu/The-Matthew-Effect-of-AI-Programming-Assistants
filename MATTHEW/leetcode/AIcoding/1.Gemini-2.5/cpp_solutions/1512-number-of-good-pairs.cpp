#include <vector>

class Solution {
public:
    int numIdenticalPairs(std::vector<int>& nums) {
        int freq[101] = {0};

        for (int num : nums) {
            freq[num]++;
        }

        int good_pairs = 0;
        for (int i = 1; i <= 100; ++i) {
            int count = freq[i];
            if (count > 1) {
                good_pairs += (count * (count - 1)) / 2;
            }
        }

        return good_pairs;
    }
};