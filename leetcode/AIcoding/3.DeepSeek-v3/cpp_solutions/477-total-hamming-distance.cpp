class Solution {
public:
    int totalHammingDistance(vector<int>& nums) {
        int total = 0, n = nums.size();
        for (int i = 0; i < 32; ++i) {
            int cnt = 0;
            for (int num : nums) {
                cnt += (num >> i) & 1;
            }
            total += cnt * (n - cnt);
        }
        return total;
    }
};