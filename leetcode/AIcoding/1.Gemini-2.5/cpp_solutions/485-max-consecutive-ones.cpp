class Solution {
public:
    int findMaxConsecutiveOnes(std::vector<int>& nums) {
        int max_consecutive = 0;
        int current_consecutive = 0;
        for (int num : nums) {
            if (num == 1) {
                current_consecutive++;
            } else {
                max_consecutive = std::max(max_consecutive, current_consecutive);
                current_consecutive = 0;
            }
        }
        max_consecutive = std::max(max_consecutive, current_consecutive);
        return max_consecutive;
    }
};