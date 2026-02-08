#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numBadPairs(const vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> count;
        int result = 0;

        for (int i = 0; i < n; ++i) {
            if (count.find(nums[i]) != count.end()) {
                result += count[nums[i]];
            }
            count[nums[i]]++;
        }

        return result;
    }
};