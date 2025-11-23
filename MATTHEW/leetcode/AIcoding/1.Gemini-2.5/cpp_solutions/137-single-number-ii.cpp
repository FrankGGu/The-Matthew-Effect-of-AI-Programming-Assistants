class Solution {
public:
    int singleNumber(std::vector<int>& nums) {
        int ones = 0;
        int twos = 0;
        int common_bit_mask = 0;

        for (int num : nums) {
            // 'twos' captures bits that have appeared twice.
            // If a bit is in 'ones' and also in 'num', it means it's now appeared twice.
            // We OR it with 'twos' to accumulate.
            twos |= (ones & num);

            // 'ones' captures bits that have appeared once.
            // XORing with 'num' toggles the bit.
            // If a bit appears once, it's set. If it appears twice, it's cleared.
            // If it appears thrice, it's set again (but then cleared by 'common_bit_mask').
            ones ^= num;

            // 'common_bit_mask' identifies bits that have appeared three times.
            // These are bits that are set in both 'ones' and 'twos' simultaneously.
            common_bit_mask = (ones & twos);

            // Clear the bits that have appeared three times from both 'ones' and 'twos'.
            // This ensures that 'ones' only holds bits that appeared once,
            // and 'twos' only holds bits that appeared twice.
            ones &= ~common_bit_mask;
            twos &= ~common_bit_mask;
        }

        // After iterating through all numbers, 'ones' will hold the single number.
        return ones;
    }
};