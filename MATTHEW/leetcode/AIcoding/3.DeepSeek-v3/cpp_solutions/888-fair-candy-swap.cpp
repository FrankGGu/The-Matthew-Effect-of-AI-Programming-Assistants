class Solution {
public:
    vector<int> fairCandySwap(vector<int>& aliceSizes, vector<int>& bobSizes) {
        int sumA = accumulate(aliceSizes.begin(), aliceSizes.end(), 0);
        int sumB = accumulate(bobSizes.begin(), bobSizes.end(), 0);
        int delta = (sumB - sumA) / 2;

        unordered_set<int> setB(bobSizes.begin(), bobSizes.end());

        for (int a : aliceSizes) {
            if (setB.count(a + delta)) {
                return {a, a + delta};
            }
        }

        return {};
    }
};