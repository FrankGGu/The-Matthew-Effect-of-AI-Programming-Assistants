class Solution {
public:
    int maxTotalFruits(vector<vector<int>>& fruits, int startPos, int k) {
        int n = fruits.size();
        vector<int> positions;
        vector<int> prefixSum;
        positions.reserve(n);
        prefixSum.reserve(n + 1);
        prefixSum.push_back(0);

        for (const auto& fruit : fruits) {
            positions.push_back(fruit[0]);
            prefixSum.push_back(prefixSum.back() + fruit[1]);
        }

        int maxFruits = 0;
        int startIdx = lower_bound(positions.begin(), positions.end(), startPos) - positions.begin();

        for (int l = 0; l <= k; ++l) {
            int r = k - 2 * l;
            if (r < 0) continue;
            int left = startPos - l;
            int right = startPos + r;
            int leftIdx = lower_bound(positions.begin(), positions.end(), left) - positions.begin();
            int rightIdx = upper_bound(positions.begin(), positions.end(), right) - positions.begin();
            if (rightIdx > leftIdx) {
                maxFruits = max(maxFruits, prefixSum[rightIdx] - prefixSum[leftIdx]);
            }
        }

        for (int r = 0; r <= k; ++r) {
            int l = k - 2 * r;
            if (l < 0) continue;
            int left = startPos - l;
            int right = startPos + r;
            int leftIdx = lower_bound(positions.begin(), positions.end(), left) - positions.begin();
            int rightIdx = upper_bound(positions.begin(), positions.end(), right) - positions.begin();
            if (rightIdx > leftIdx) {
                maxFruits = max(maxFruits, prefixSum[rightIdx] - prefixSum[leftIdx]);
            }
        }

        return maxFruits;
    }
};