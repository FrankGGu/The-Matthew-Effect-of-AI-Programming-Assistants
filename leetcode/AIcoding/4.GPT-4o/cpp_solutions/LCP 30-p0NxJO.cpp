class Solution {
public:
    int magicTower(vector<int>& nums) {
        long long sum = 0, minHealth = 0;
        for (int num : nums) {
            sum += num;
            if (sum < 1) {
                minHealth += 1 - sum;
                sum = 1;
            }
        }
        return minHealth + 1;
    }
};