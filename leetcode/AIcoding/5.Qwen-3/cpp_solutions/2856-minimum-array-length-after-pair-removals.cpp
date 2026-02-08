#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int minLengthAfterRemovals(vector<int>& nums) {
        map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int maxFreq = 0;
        int total = nums.size();

        for (auto& [num, count] : freq) {
            maxFreq = max(maxFreq, count);
        }

        if (maxFreq > total / 2) {
            return 2 * maxFreq - total;
        } else {
            return total % 2;
        }
    }
};