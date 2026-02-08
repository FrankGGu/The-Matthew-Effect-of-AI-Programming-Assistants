#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> findPrefixScores(vector<int>& nums) {
        int n = nums.size();
        vector<long long> result(n);
        long long score = 0;
        long long prefixSum = 0;

        for (int i = 0; i < n; ++i) {
            prefixSum += nums[i];
            score += prefixSum;
            result[i] = score;
        }

        return result;
    }
};