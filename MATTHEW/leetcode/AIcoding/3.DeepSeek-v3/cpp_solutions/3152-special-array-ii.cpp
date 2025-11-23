class Solution {
public:
    vector<bool> isArraySpecial(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<int> prefix(n, 0);
        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i-1] + ((nums[i] % 2) == (nums[i-1] % 2));
        }
        vector<bool> res;
        for (auto& q : queries) {
            int x = q[0], y = q[1];
            if (x == y) {
                res.push_back(true);
            } else {
                res.push_back(prefix[y] - prefix[x] == 0);
            }
        }
        return res;
    }
};