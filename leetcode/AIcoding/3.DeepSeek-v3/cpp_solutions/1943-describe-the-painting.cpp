class Solution {
public:
    vector<vector<long long>> splitPainting(vector<vector<int>>& segments) {
        map<int, long long> colorChanges;
        for (auto& seg : segments) {
            int start = seg[0], end = seg[1], color = seg[2];
            colorChanges[start] += color;
            colorChanges[end] -= color;
        }

        vector<vector<long long>> result;
        long long currentColor = 0;
        int prevPos = -1;
        for (auto& [pos, delta] : colorChanges) {
            if (prevPos != -1 && currentColor != 0) {
                result.push_back({prevPos, pos, currentColor});
            }
            currentColor += delta;
            prevPos = pos;
        }

        return result;
    }
};