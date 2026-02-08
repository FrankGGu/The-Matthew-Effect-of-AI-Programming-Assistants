class Solution {
public:
    int maximumStrength(vector<int>& nums) {
        int product = 1;
        int negativeCount = 0;
        bool hasZero = false;

        for (int num : nums) {
            if (num < 0) {
                negativeCount++;
            }
            if (num == 0) {
                hasZero = true;
            }
            if (num != 0) {
                product *= num;
            }
        }

        if (negativeCount % 2 == 1) {
            if (negativeCount == 1 && !hasZero) {
                return 0;
            }
            product /= *max_element(nums.begin(), nums.end());
        }

        return product;
    }
};