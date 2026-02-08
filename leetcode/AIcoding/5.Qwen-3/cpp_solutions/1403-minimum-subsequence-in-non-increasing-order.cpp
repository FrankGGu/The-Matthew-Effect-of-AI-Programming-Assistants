#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> minSubsequence(int n, vector<int>& nums) {
        sort(nums.begin(), nums.end(), greater<int>());
        vector<int> result;
        int sum = 0;
        for (int num : nums) {
            sum += num;
            result.push_back(num);
            if (sum > n - sum) {
                break;
            }
        }
        return result;
    }
};