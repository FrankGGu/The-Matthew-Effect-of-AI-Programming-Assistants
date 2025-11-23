class Solution {
public:
    int sumImbalanceNumbers(vector<int>& nums) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            unordered_set<int> s;
            s.insert(nums[i]);
            int cnt = 0;
            for (int j = i + 1; j < n; ++j) {
                if (!s.count(nums[j])) {
                    int imbalance = 1;
                    if (s.count(nums[j] + 1)) imbalance--;
                    if (s.count(nums[j] - 1)) imbalance--;
                    cnt += imbalance;
                    s.insert(nums[j]);
                }
                res += cnt;
            }
        }
        return res;
    }
};