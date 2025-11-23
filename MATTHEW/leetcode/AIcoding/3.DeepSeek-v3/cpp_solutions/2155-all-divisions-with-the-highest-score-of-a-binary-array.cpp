class Solution {
public:
    vector<int> maxScoreIndices(vector<int>& nums) {
        int n = nums.size();
        vector<int> leftZeros(n + 1, 0);
        vector<int> rightOnes(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            leftZeros[i] = leftZeros[i - 1] + (nums[i - 1] == 0 ? 1 : 0);
        }

        for (int i = n - 1; i >= 0; --i) {
            rightOnes[i] = rightOnes[i + 1] + (nums[i] == 1 ? 1 : 0);
        }

        int maxScore = 0;
        vector<int> result;

        for (int i = 0; i <= n; ++i) {
            int currentScore = leftZeros[i] + rightOnes[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                result.clear();
                result.push_back(i);
            } else if (currentScore == maxScore) {
                result.push_back(i);
            }
        }

        return result;
    }
};