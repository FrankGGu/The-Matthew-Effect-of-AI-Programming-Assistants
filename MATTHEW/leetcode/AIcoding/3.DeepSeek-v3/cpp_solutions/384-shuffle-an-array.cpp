class Solution {
private:
    vector<int> original;
    vector<int> shuffled;
public:
    Solution(vector<int>& nums) {
        original = nums;
        shuffled = nums;
    }

    vector<int> reset() {
        return original;
    }

    vector<int> shuffle() {
        for (int i = shuffled.size() - 1; i > 0; --i) {
            int j = rand() % (i + 1);
            swap(shuffled[i], shuffled[j]);
        }
        return shuffled;
    }
};