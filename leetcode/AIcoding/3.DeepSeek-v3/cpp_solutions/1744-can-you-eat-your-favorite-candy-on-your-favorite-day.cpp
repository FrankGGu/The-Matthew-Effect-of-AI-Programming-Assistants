class Solution {
public:
    vector<bool> canEat(vector<int>& candiesCount, vector<vector<int>>& queries) {
        int n = candiesCount.size();
        vector<long long> prefix(n + 1);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + candiesCount[i];
        }
        vector<bool> res;
        for (auto& q : queries) {
            int type = q[0], day = q[1], cap = q[2];
            long long minCandies = day + 1;
            long long maxCandies = (long long)(day + 1) * cap;
            long long typeMin = prefix[type] + 1;
            long long typeMax = prefix[type + 1];
            res.push_back(!(maxCandies < typeMin || minCandies > typeMax));
        }
        return res;
    }
};