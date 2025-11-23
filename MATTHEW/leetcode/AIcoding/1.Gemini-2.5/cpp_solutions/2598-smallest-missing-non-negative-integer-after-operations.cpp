#include <vector>
#include <map>

class Solution {
public:
    int smallestMissingInteger(std::vector<int>& nums, int value) {
        std::map<int, int> counts;

        for (int num : nums) {
            long long remainder = (1LL * num % value + value) % value;
            counts[remainder]++;
        }

        int m = 0;
        while (true) {
            int remainder_for_m = m % value;

            if (counts[remainder_for_m] > 0) {
                counts[remainder_for_m]--;
                m++;
            } else {
                return m;
            }
        }
    }
};