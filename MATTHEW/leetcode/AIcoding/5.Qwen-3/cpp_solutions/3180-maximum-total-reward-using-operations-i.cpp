#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maxTotalReward(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        unordered_set<int> s;
        for (int num : nums) {
            if (num > 0 && s.find(num - 1) != s.end()) {
                s.insert(num);
            } else if (s.find(num) == s.end()) {
                s.insert(num);
            }
        }
        int maxVal = 0;
        for (int val : s) {
            maxVal = max(maxVal, val);
        }
        return maxVal;
    }
};