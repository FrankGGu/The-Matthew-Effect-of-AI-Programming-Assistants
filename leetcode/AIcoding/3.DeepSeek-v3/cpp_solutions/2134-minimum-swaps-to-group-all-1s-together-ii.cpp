class Solution {
public:
    int minSwaps(vector<int>& nums) {
        int n = nums.size();
        int totalOnes = count(nums.begin(), nums.end(), 1);
        if (totalOnes == 0 || totalOnes == n) {
            return 0;
        }

        vector<int> circular(nums.begin(), nums.end());
        circular.insert(circular.end(), nums.begin(), nums.end());

        int maxOnesInWindow = 0;
        int currentOnes = 0;

        for (int i = 0; i < totalOnes; ++i) {
            currentOnes += circular[i];
        }
        maxOnesInWindow = currentOnes;

        for (int i = totalOnes; i < 2 * n; ++i) {
            currentOnes += circular[i] - circular[i - totalOnes];
            maxOnesInWindow = max(maxOnesInWindow, currentOnes);
        }

        return totalOnes - maxOnesInWindow;
    }
};