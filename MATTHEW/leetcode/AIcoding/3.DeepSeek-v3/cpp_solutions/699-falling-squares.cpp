class Solution {
public:
    vector<int> fallingSquares(vector<vector<int>>& positions) {
        vector<int> res;
        vector<pair<int, int>> intervals;
        int max_height = 0;
        for (auto &pos : positions) {
            int left = pos[0], side = pos[1], right = left + side;
            int current_height = side;
            for (auto &interval : intervals) {
                if (interval.first < right && left < interval.second) {
                    current_height = max(current_height, side + interval.second);
                }
            }
            intervals.emplace_back(left, current_height);
            intervals.emplace_back(right, 0);
            max_height = max(max_height, current_height);
            res.push_back(max_height);
        }
        return res;
    }
};