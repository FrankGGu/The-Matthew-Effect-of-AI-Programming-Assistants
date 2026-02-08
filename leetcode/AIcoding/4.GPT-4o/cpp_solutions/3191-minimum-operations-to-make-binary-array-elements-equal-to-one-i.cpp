class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int zeroCount = count(nums.begin(), nums.end(), 0);
        int leftZeroes = 0, rightZeroes = zeroCount;
        int minOps = zeroCount;

        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) {
                leftZeroes++;
                rightZeroes--;
            }
            minOps = min(minOps, leftZeroes + rightZeroes);
        }
        return minOps;
    }
};