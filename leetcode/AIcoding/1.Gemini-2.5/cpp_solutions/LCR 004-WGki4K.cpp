class Solution {
public:
    int singleNumber(std::vector<int>& nums) {
        int ones = 0;
        int twos = 0;

        for (int num : nums) {
            twos |= (ones & num);
            ones ^= num;
            int common_bits = ones & twos;
            ones &= ~common_bits;
            twos &= ~common_bits;
        }

        return ones;
    }
};