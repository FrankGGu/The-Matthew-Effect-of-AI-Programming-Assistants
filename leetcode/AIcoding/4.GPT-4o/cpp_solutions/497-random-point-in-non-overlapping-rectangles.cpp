class Solution {
public:
    vector<int> preSum;
    vector<vector<int>> rects;

    Solution(vector<vector<int>>& rects) {
        this->rects = rects;
        preSum.push_back(0);
        for (const auto& rect : rects) {
            int area = (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1);
            preSum.push_back(preSum.back() + area);
        }
    }

    vector<int> pick() {
        int totalArea = preSum.back() - 1;
        int target = rand() % totalArea;
        int idx = upper_bound(preSum.begin(), preSum.end(), target) - preSum.begin() - 1;

        const auto& rect = rects[idx];
        int x = rect[0] + rand() % (rect[2] - rect[0] + 1);
        int y = rect[1] + rand() % (rect[3] - rect[1] + 1);

        return {x, y};
    }
};