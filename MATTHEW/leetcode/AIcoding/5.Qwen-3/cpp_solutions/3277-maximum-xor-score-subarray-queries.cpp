#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> maxXORScores(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        int q = queries.size();
        vector<int> result(q, 0);

        for (int i = 0; i < q; ++i) {
            int l = queries[i][0];
            int r = queries[i][1];
            int maxScore = INT_MIN;
            int currentXOR = 0;
            for (int j = l; j <= r; ++j) {
                currentXOR ^= nums[j];
                maxScore = max(maxScore, currentXOR);
            }
            result[i] = maxScore;
        }

        return result;
    }
};