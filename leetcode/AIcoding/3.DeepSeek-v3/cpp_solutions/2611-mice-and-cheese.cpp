class Solution {
public:
    int miceAndCheese(vector<int>& reward1, vector<int>& reward2, int k) {
        int n = reward1.size();
        vector<pair<int, int>> diff;
        for (int i = 0; i < n; ++i) {
            diff.emplace_back(reward1[i] - reward2[i], i);
        }
        sort(diff.begin(), diff.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        });
        int res = 0;
        for (int i = 0; i < k; ++i) {
            res += reward1[diff[i].second];
        }
        for (int i = k; i < n; ++i) {
            res += reward2[diff[i].second];
        }
        return res;
    }
};