class Solution {
public:
    int minimizeOr(vector<int>& nums) {
        int res = 0;
        for (int bit = 30; bit >= 0; --bit) {
            int mask = res | (1 << bit);
            int cnt = 0;
            int current_or = 0;
            for (int num : nums) {
                if ((num & mask) == mask) {
                    current_or |= num;
                    cnt++;
                }
            }
            if (cnt > 0 && (current_or & mask) == mask) {
                res = mask;
            }
        }
        return res;
    }
};