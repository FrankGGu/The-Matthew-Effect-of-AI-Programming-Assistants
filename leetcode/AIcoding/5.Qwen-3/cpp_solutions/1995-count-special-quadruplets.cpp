#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countQuadruplets(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        unordered_map<int, int> freq;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    int target = nums[i] + nums[j] + nums[k];
                    count += freq[target];
                }
            }
            freq[nums[i]]++;
        }
        return count;
    }
};