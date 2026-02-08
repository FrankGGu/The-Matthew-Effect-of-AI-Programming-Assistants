class Solution {
public:
    int minimumIndex(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int total = 0;
        for (int num : nums) {
            total += (count[num] > 0);
        }

        int leftCount = 0, rightCount = total;
        for (int i = 0; i < n - 1; ++i) {
            leftCount++;
            count[nums[i]]--;
            rightCount--;

            if (count[nums[i]] == 0) {
                total--;
            }

            if (leftCount > rightCount) {
                return i;
            }
        }

        return -1;
    }
};