class Solution {
public:
    int maxFruits(vector<vector<int>>& fruits, int k) {
        int n = fruits.size();
        int maxFruits = 0;
        int left = 0, right = 0;
        int currentSteps = 0;

        while (right < n) {
            currentSteps += fruits[right][0];
            while (currentSteps > k) {
                currentSteps -= fruits[left][0];
                left++;
            }
            maxFruits = max(maxFruits, (right - left + 1));
            right++;
        }

        return maxFruits;
    }
};