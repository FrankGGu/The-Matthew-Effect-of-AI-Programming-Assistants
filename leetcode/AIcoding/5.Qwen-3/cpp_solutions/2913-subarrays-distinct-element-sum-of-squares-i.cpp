#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int sumSquares(vector<int>& nums) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<int, int> count;
            for (int j = i; j < n; ++j) {
                count[nums[j]]++;
                if (count[nums[j]] == 1) {
                    result += nums[j] * nums[j];
                }
            }
        }
        return result;
    }
};