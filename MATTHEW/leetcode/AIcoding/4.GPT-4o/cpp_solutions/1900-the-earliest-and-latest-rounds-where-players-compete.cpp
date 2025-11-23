class Solution {
public:
    vector<vector<int>> earliestAndLatest(int n, int firstPlayer) {
        vector<vector<int>> result;
        for (int round = 1; round <= n; ++round) {
            vector<int> res = {firstPlayer, round};
            result.push_back(res);
        }
        return result;
    }
};