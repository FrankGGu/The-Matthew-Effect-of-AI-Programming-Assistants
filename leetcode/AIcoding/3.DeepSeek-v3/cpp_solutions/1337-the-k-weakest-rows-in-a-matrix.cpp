class Solution {
public:
    vector<int> kWeakestRows(vector<vector<int>>& mat, int k) {
        vector<pair<int, int>> rows;
        for (int i = 0; i < mat.size(); ++i) {
            int soldiers = 0;
            for (int num : mat[i]) {
                if (num == 1) {
                    soldiers++;
                } else {
                    break;
                }
            }
            rows.emplace_back(soldiers, i);
        }
        sort(rows.begin(), rows.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            if (a.first == b.first) {
                return a.second < b.second;
            }
            return a.first < b.first;
        });
        vector<int> result;
        for (int i = 0; i < k; ++i) {
            result.push_back(rows[i].second);
        }
        return result;
    }
};