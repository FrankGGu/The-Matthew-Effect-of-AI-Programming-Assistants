class Solution {
public:
    int flipgame(vector<int>& fronts, vector<int>& backs) {
        unordered_set<int> bad;
        for (int i = 0; i < fronts.size(); ++i) {
            if (fronts[i] == backs[i]) {
                bad.insert(fronts[i]);
            }
        }
        int ans = INT_MAX;
        for (int i = 0; i < fronts.size(); ++i) {
            if (bad.find(fronts[i]) == bad.end()) {
                ans = min(ans, fronts[i]);
            }
            if (bad.find(backs[i]) == bad.end()) {
                ans = min(ans, backs[i]);
            }
        }
        return ans == INT_MAX ? 0 : ans;
    }
};