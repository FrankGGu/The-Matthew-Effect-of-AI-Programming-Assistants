class Solution {
public:
    int findKOr(std::vector<int>& nums, int k) {
        int k_or_result = 0;
        for (int i = 0; i < 31; ++i) {
            int count_set_bits = 0;
            for (int num : nums) {
                if ((num >> i) & 1) {
                    count_set_bits++;
                }
            }
            if (count_set_bits >= k) {
                k_or_result |= (1 << i);
            }
        }
        return k_or_result;
    }
};