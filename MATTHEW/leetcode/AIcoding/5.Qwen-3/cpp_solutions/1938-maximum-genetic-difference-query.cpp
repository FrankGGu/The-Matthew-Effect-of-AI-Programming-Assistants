#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getMaximumXorQuery(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        int m = queries.size();
        vector<int> result(m);

        int max_xor = 0;
        for (int num : nums) {
            max_xor ^= num;
        }

        for (int i = 0; i < m; ++i) {
            int l = queries[i][0];
            int r = queries[i][1];
            int x = queries[i][2];

            int xor_val = 0;
            for (int j = l; j <= r; ++j) {
                xor_val ^= nums[j];
            }
            result[i] = xor_val ^ x;
        }

        return result;
    }
};