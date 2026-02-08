class Solution {
public:
    int maximumBeauty(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> maxCount(100001, 0);
        for (int num : nums) {
            maxCount[max(0, num - k)]++;
            maxCount[min(100000, num + k + 1)]--;
        }
        int max_beauty = 0, current_beauty = 0;
        for (int i = 0; i <= 100000; i++) {
            current_beauty += maxCount[i];
            max_beauty = max(max_beauty, current_beauty);
        }
        return max_beauty;
    }
};