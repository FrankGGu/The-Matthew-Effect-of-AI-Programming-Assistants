class Solution {
public:
    int maxDistance(vector<vector<int>>& arrays) {
        int min_val = arrays[0][0];
        int max_val = arrays[0].back();
        int res = 0;

        for (int i = 1; i < arrays.size(); ++i) {
            int current_min = arrays[i][0];
            int current_max = arrays[i].back();
            res = max(res, max(max_val - current_min, current_max - min_val));
            min_val = min(min_val, current_min);
            max_val = max(max_val, current_max);
        }

        return res;
    }
};