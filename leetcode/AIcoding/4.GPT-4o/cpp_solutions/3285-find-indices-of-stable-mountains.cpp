class Solution {
public:
    vector<int> findStableMountains(vector<int>& heights) {
        vector<int> result;
        int n = heights.size();
        for (int i = 1; i < n - 1; ++i) {
            if (heights[i] > heights[i - 1] && heights[i] > heights[i + 1]) {
                result.push_back(i);
            }
        }
        return result;
    }
};