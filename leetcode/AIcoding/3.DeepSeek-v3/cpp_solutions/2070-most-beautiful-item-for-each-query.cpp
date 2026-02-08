class Solution {
public:
    vector<int> maximumBeauty(vector<vector<int>>& items, vector<int>& queries) {
        sort(items.begin(), items.end());
        vector<int> maxBeauty;
        int currentMax = 0;
        for (const auto& item : items) {
            currentMax = max(currentMax, item[1]);
            maxBeauty.push_back(currentMax);
        }

        vector<int> res;
        for (int q : queries) {
            int left = 0, right = items.size() - 1;
            int best = 0;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (items[mid][0] <= q) {
                    best = maxBeauty[mid];
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            res.push_back(best);
        }
        return res;
    }
};