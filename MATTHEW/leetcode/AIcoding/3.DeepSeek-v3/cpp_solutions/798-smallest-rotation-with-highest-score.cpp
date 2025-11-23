class Solution {
public:
    int bestRotation(vector<int>& nums) {
        int n = nums.size();
        vector<int> change(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            int left = (i - nums[i] + 1 + n) % n;
            int right = (i + 1) % n;
            change[left]--;
            change[right]++;
            if (left > right) {
                change[0]--;
            }
        }

        int best_k = 0;
        int max_score = 0;
        int current_score = 0;

        for (int k = 0; k < n; ++k) {
            current_score += change[k];
            if (current_score > max_score) {
                max_score = current_score;
                best_k = k;
            }
        }

        return best_k;
    }
};