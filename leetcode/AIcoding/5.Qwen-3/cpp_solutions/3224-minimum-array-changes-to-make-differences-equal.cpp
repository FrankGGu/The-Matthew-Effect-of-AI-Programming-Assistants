#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minChanges(vector<int>& nums, int k) {
        vector<int> freq(1024, 0);
        for (int num : nums) {
            ++freq[num];
        }

        int changes = 0;
        for (int i = 0; i < k; ++i) {
            int max_freq = 0;
            for (int j = i; j < nums.size(); j += k) {
                max_freq = max(max_freq, freq[nums[j]]);
            }
            changes += (nums.size() / k) - max_freq;
        }

        return changes;
    }
};