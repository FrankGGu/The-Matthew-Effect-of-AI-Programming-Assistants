class Solution {
public:
    vector<int> nums;
    int total;
    Solution(int n_rows, int n_cols) {
        total = n_rows * n_cols;
        nums.resize(total);
        iota(nums.begin(), nums.end(), 0);
    }

    vector<int> flip() {
        int index = rand() % total;
        int randomNum = nums[index];
        nums[index] = nums[total - 1];
        total--;
        return {randomNum / nums.size(), randomNum % nums.size()};
    }

    void reset() {
        total = nums.size();
        for (int i = 0; i < nums.size(); i++) {
            nums[i] = i;
        }
    }
};