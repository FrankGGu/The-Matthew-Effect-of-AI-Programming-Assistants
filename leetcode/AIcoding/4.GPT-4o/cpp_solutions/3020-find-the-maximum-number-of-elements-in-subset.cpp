class Solution {
public:
    int maximizeSubsetSize(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int count = 0, sum = 0;
        for (int num : nums) {
            if (sum + num <= nums.size()) {
                sum += num;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};