class Solution {
public:
    int maximumCount(std::vector<int>& nums) {
        int posCount = 0;
        int negCount = 0;
        for (int num : nums) {
            if (num > 0) {
                posCount++;
            } else if (num < 0) {
                negCount++;
            }
        }
        return std::max(posCount, negCount);
    }
};