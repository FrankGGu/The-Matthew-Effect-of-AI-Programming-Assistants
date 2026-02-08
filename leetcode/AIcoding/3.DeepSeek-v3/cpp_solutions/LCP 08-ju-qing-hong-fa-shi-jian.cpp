class Solution {
public:
    vector<int> getTriggerTime(vector<vector<int>>& increase, vector<vector<int>>& requirements) {
        int n = increase.size();
        vector<vector<int>> prefix(n + 1, vector<int>(3, 0));
        for (int i = 0; i < n; ++i) {
            prefix[i + 1][0] = prefix[i][0] + increase[i][0];
            prefix[i + 1][1] = prefix[i][1] + increase[i][1];
            prefix[i + 1][2] = prefix[i][2] + increase[i][2];
        }
        vector<int> res;
        for (auto& req : requirements) {
            int left = 0, right = n;
            int ans = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (prefix[mid][0] >= req[0] && prefix[mid][1] >= req[1] && prefix[mid][2] >= req[2]) {
                    ans = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            res.push_back(ans);
        }
        return res;
    }
};