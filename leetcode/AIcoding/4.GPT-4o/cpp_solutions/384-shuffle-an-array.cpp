class Solution {
public:
    vector<int> original;

    Solution(vector<int>& nums) {
        original = nums;
    }

    vector<int> reset() {
        return original;
    }

    vector<int> shuffle() {
        vector<int> shuffled = original;
        random_shuffle(shuffled.begin(), shuffled.end());
        return shuffled;
    }
};