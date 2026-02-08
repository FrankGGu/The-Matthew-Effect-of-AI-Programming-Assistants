#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> maximizeXOR(vector<int>& nums, vector<vector<int>>& queries) {
        sort(nums.begin(), nums.end());
        vector<int> res(queries.size(), 0);
        for (int i = 0; i < queries.size(); ++i) {
            int x = queries[i][0];
            int m = queries[i][1];
            int max_xor = 0;
            for (int num : nums) {
                if (num > m) break;
                max_xor = max(max_xor, x ^ num);
            }
            res[i] = max_xor;
        }
        return res;
    }
};