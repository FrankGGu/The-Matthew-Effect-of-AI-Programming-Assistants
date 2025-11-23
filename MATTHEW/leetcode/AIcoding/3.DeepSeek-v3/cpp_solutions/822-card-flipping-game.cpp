class Solution {
public:
    int flipgame(vector<int>& fronts, vector<int>& backs) {
        unordered_set<int> same;
        for (int i = 0; i < fronts.size(); ++i) {
            if (fronts[i] == backs[i]) {
                same.insert(fronts[i]);
            }
        }
        int res = INT_MAX;
        for (int num : fronts) {
            if (same.find(num) == same.end()) {
                res = min(res, num);
            }
        }
        for (int num : backs) {
            if (same.find(num) == same.end()) {
                res = min(res, num);
            }
        }
        return res == INT_MAX ? 0 : res;
    }
};