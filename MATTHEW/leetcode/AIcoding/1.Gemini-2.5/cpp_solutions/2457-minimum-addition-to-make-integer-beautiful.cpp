class Solution {
public:
    long long sum_digits(long long num) {
        long long sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }

    long long makeBeautiful(long long n, int target) {
        if (sum_digits(n) <= target) {
            return 0;
        }

        long long current_n_val = n;
        long long addition = 0;
        long long power_of_10 = 1;

        while (sum_digits(current_n_val) > target) {
            long long digit = (current_n_val / power_of_10) % 10;

            long long needed_to_carry = (10 - digit) % 10; 

            if (needed_to_carry == 0) {
                power_of_10 *= 10;
                continue;
            }

            long long amount_to_add = needed_to_carry * power_of_10;
            addition += amount_to_add;
            current_n_val += amount_to_add;

            power_of_10 *= 10;
        }

        return addition;
    }
};