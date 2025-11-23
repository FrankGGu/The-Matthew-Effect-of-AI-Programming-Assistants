class Solution {
public:
    int rectangleArea(vector<vector<int>>& rectangles) {
        const int MOD = 1e9 + 7;
        vector<int> xs;
        for (const auto& rect : rectangles) {
            xs.push_back(rect[0]);
            xs.push_back(rect[2]);
        }
        sort(xs.begin(), xs.end());
        xs.erase(unique(xs.begin(), xs.end()), xs.end());

        int n = xs.size();
        vector<int> heights(n - 1, 0);
        vector<int> count(n - 1, 0);
        long long area = 0;

        for (const auto& rect : rectangles) {
            int left = lower_bound(xs.begin(), xs.end(), rect[0]) - xs.begin();
            int right = lower_bound(xs.begin(), xs.end(), rect[2]) - xs.begin();
            for (int i = left; i < right; ++i) {
                count[i]++;
                heights[i] = max(heights[i], rect[3]);
            }
        }

        for (int i = 0; i < n - 1; ++i) {
            if (count[i] > 0) {
                area = (area + (long long)(xs[i + 1] - xs[i]) * heights[i]) % MOD) % MOD;
            }
        }

        return area;
    }
};