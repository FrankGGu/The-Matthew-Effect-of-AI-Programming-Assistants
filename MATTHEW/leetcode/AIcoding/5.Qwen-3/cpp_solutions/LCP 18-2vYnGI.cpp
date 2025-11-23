#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> breakfastRotation(vector<int>& nums) {
        int n = nums.size();
        vector<int> res;
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        int maxFreq = 0;
        for (auto& [key, val] : count) {
            maxFreq = max(maxFreq, val);
        }
        int minRotations = n - maxFreq;
        res.push_back(minRotations);
        return res;
    }
};