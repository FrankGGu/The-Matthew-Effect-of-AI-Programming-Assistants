#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minOperationsToMakeKSubarraysEqual(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> freq(k, 0);
        for (int i = 0; i < k; ++i) {
            freq[i] = 1;
        }
        for (int i = k; i < n; ++i) {
            if (nums[i] == nums[i - k]) {
                freq[i % k]++;
            } else {
                freq[i % k] = 1;
            }
        }
        int maxFreq = *max_element(freq.begin(), freq.end());
        return n - maxFreq;
    }
};