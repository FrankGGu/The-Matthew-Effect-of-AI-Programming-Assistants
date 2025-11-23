#include <stdbool.h>
#include <math.h>

bool checkPerfectNumber(int num) {
    if (num <= 1) return false;
    int sum = 1;
    int sqrtNum = (int)sqrt(num);
    for (int i = 2; i <= sqrtNum; i++) {
        if (num % i == 0) {
            sum += i;
            int other = num / i;
            if (other != i) {
                sum += other;
            }
        }
    }
    return sum == num;
}