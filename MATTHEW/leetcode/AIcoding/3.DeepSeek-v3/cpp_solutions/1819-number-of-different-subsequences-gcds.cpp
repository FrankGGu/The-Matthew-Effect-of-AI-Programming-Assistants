class Solution {
public:
    int countDifferentSubsequenceGCDs(vector<int>& nums) {
        int max_num = *max_element(nums.begin(), nums.end());
        vector<bool> present(max_num + 1, false);
        for (int num : nums) {
            present[num] = true;
        }
        int res = 0;
        for (int i = 1; i <= max_num; ++i) {
            int current_gcd = 0;
            for (int j = i; j <= max_num; j += i) {
                if (present[j]) {
                    current_gcd = gcd(current_gcd, j);
                    if (current_gcd == i) {
                        ++res;
                        break;
                    }
                }
            }
        }
        return res;
    }
};