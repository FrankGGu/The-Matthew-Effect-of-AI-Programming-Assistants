class Solution {
public:
    vector<int> fallingSquares(vector<vector<int>>& positions) {
        vector<int> heights;
        vector<int> result;
        int max_height = 0;

        for (auto& pos : positions) {
            int left = pos[0], size = pos[1];
            int right = left + size;
            int new_height = 0;

            for (int i = 0; i < heights.size(); ++i) {
                if (positions[i][0] < right && positions[i][0] + positions[i][1] > left) {
                    new_height = max(new_height, heights[i]);
                }
            }
            new_height += size;
            heights.push_back(new_height);
            max_height = max(max_height, new_height);
            result.push_back(max_height);
        }
        return result;
    }
};