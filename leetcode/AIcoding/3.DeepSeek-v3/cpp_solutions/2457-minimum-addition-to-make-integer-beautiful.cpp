class Solution {
public:
    long long makeIntegerBeautiful(long long n, int target) {
        auto digitSum = [](long long num) {
            int sum = 0;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            return sum;
        };

        long long original = n;
        long long add = 0;
        long long power = 1;

        while (digitSum(n + add) > target) {
            power *= 10;
            add = power - (n % power);
        }

        return add;
    }
};