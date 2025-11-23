class Solution {
public:
    int findNthDigit(int n) {
        long long N = n; 

        long long digits = 1;
        long long count = 9;
        long long power_of_10 = 1;

        while (N > digits * count) {
            N -= digits * count;
            digits++;
            count *= 10;
            power_of_10 *= 10;
        }

        long long num_index_in_block = (N - 1) / digits;
        long long target_number = power_of_10 + num_index_in_block;

        long long digit_index_in_num = (N - 1) % digits; 

        long long divisor_power = digits - 1 - digit_index_in_num;
        long long divisor = 1;
        for (int i = 0; i < divisor_power; ++i) {
            divisor *= 10;
        }

        return (target_number / divisor) % 10;
    }
};