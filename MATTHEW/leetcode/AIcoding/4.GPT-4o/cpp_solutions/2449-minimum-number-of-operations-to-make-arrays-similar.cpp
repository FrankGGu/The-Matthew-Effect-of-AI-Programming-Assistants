class Solution {
public:
    int minOperations(vector<int>& nums, vector<int>& target) {
        sort(nums.begin(), nums.end());
        sort(target.begin(), target.end());

        int n = nums.size();
        long long sum1 = 0, sum2 = 0;

        for (int i = 0; i < n; i++) {
            sum1 += nums[i];
            sum2 += target[i];
        }

        if (sum1 < sum2) {
            return -1;
        }

        vector<int> count1(1001, 0), count2(1001, 0);

        for (int num : nums) count1[num]++;
        for (int num : target) count2[num]++;

        int operations = 0;

        for (int i = 0; i < 1001; i++) {
            if (count1[i] > count2[i]) {
                operations += count1[i] - count2[i];
            }
        }

        return operations / 2;
    }
};