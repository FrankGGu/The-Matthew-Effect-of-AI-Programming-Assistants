class Solution {
public:
    int bestRotation(vector<int>& nums) {
        int n = nums.size();
        vector<int> score(n, 0);

        for (int i = 0; i < n; ++i) {
            int left = (i - nums[i] + 1 + n) % n;
            int right = (i + 1) % n;
            score[left]++;
            if (right != left) {
                score[right]--;
            }
        }

        int maxScore = 0, maxIndex = 0, currentScore = 0;
        for (int i = 0; i < n; ++i) {
            currentScore += score[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                maxIndex = i;
            }
        }

        return maxIndex;
    }
};