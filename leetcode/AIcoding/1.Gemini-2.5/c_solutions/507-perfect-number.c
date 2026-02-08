#include <stdbool.h>

bool checkPerfectNumber(int num) {
    if (num <= 1) {
        return false;
    }

    int sum_divisors = 1; // 1 is always a divisor

    for (int i = 2; (long long)i * i <= num; i++) { // Use long long for i*i to prevent overflow
        if (num % i == 0) {
            sum_divisors += i;
            if (i * i != num) {
                sum_divisors += num / i;
            }
        }
    }

    return sum_divisors == num;
}