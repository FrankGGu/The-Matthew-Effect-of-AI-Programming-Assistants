class Solution {
public:
    int countDifferentSubsequenceGCDs(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        vector<bool> present(maxNum + 1, false);
        for (int num : nums) {
            present[num] = true;
        }

        int count = 0;
        for (int gcd = 1; gcd <= maxNum; ++gcd) {
            int currentGCD = 0;
            for (int multiple = gcd; multiple <= maxNum; multiple += gcd) {
                if (present[multiple]) {
                    currentGCD = gcd;
                }
            }
            if (currentGCD == gcd) {
                count++;
            }
        }

        return count;
    }
};