long long makeIntegerBeautiful(long long n, int target) {
    long long sum = 0;
    long long temp = n;
    while (temp > 0) {
        sum += temp % 10;
        temp /= 10;
    }

    if (sum <= target) {
        return 0;
    }

    long long factor = 1;
    long long result = 0;
    temp = n;

    while (sum > target) {
        long long digit = temp % 10;
        if (digit != 0) {
            long long add = (10 - digit) * factor;
            result += add;
            temp += add;
            sum = 0;
            long long t = temp;
            while (t > 0) {
                sum += t % 10;
                t /= 10;
            }
        }
        factor *= 10;
        temp /= 10;
    }

    return result;
}