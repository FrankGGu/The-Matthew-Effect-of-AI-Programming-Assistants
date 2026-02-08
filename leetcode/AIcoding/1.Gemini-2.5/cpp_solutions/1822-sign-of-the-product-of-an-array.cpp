class Solution {
public:
    int arraySign(std::vector<int>& nums) {
        int sign = 1; // Start with a positive sign

        for (int num : nums) {
            if (num == 0) {
                return 0; // If any number is 0, the product is 0
            } else if (num < 0) {
                sign = -sign; // Flip the sign for each negative number
            }
        }

        return sign; // Return the final sign
    }
};