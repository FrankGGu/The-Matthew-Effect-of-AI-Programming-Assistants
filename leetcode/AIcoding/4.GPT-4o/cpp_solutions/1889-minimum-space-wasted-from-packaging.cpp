class Solution {
public:
    int minWastedSpace(vector<int>& packages, vector<vector<int>>& boxes) {
        sort(packages.begin(), packages.end());
        int total = accumulate(packages.begin(), packages.end(), 0);
        int minWaste = INT_MAX;

        for (const auto& box : boxes) {
            if (box.size() < packages.size()) continue;
            sort(box.begin(), box.end());
            int waste = 0, j = 0;
            for (const auto& b : box) {
                int sum = 0;
                while (j < packages.size() && packages[j] <= b) {
                    sum += packages[j++];
                }
                waste += b * (j - (j - sum));
            }
            if (j == packages.size()) {
                minWaste = min(minWaste, waste - total);
            }
        }

        return minWaste == INT_MAX ? -1 : minWaste;
    }
};