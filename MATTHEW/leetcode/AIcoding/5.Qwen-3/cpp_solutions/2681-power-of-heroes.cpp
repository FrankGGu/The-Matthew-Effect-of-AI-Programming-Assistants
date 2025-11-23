#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int strongestPair(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int maxStrength = 0;
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        for (int i = 0; i < n; ++i) {
            int a = nums[i];
            int b = nums[n - 1 - i];
            if (a <= b && freq[a] > 0 && freq[b] > 0) {
                maxStrength = max(maxStrength, b - a);
            }
        }
        return maxStrength;
    }
};