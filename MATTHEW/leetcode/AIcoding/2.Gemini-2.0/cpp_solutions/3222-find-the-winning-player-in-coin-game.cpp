class Solution {
public:
    bool winnerOfGame(vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return false;
        }
        int a_moves = 0;
        int b_moves = 0;
        for (int i = 1; i < n - 1; ++i) {
            if (nums[i - 1] == nums[i] && nums[i] == nums[i + 1]) {
                if (nums[i] == 0) {
                    a_moves++;
                } else {
                    b_moves++;
                }
            }
        }
        return a_moves > b_moves;
    }
};