class Solution {
private:
    vector<vector<int>> rects;
    vector<int> prefix;
    int total;

public:
    Solution(vector<vector<int>>& rects) {
        this->rects = rects;
        prefix.push_back(0);
        for (auto& rect : rects) {
            int area = (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1);
            prefix.push_back(prefix.back() + area);
        }
        total = prefix.back();
    }

    vector<int> pick() {
        int r = rand() % total;
        int idx = upper_bound(prefix.begin(), prefix.end(), r) - prefix.begin() - 1;
        auto& rect = rects[idx];
        int x = rect[0] + rand() % (rect[2] - rect[0] + 1);
        int y = rect[1] + rand() % (rect[3] - rect[1] + 1);
        return {x, y};
    }
};