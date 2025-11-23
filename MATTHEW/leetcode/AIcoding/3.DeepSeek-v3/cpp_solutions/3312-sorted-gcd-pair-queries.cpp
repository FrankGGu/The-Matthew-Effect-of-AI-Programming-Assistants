class Solution {
public:
    vector<int> solveQueries(vector<int>& nums, vector<vector<int>>& queries) {
        vector<int> res;
        for (auto& q : queries) {
            int x = q[0], y = q[1];
            int g = 0;
            for (int i = x; i <= y; ++i) {
                g = __gcd(g, nums[i]);
            }
            res.push_back(g);
        }
        return res;
    }
};