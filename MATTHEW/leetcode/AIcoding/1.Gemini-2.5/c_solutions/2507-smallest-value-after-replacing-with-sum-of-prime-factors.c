#include <stdbool.h>
#include <math.h>

bool isPrime(int num) {
    if (num <= 1) {
        return false;
    }
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) {
            return false;
        }
    }
    return true;
}

int sumPrimeFactors(int num) {
    int sum = 0;
    int temp_n = num;

    for (int i = 2; i * i <= temp_n; i++) {
        while (temp_n % i == 0) {
            sum += i;
            temp_n /= i;
        }
    }

    if (temp_n > 1) {
        sum += temp_n;
    }

    return sum;
}

int smallestValue(int n) {
    while (!isPrime(n)) {
        n = sumPrimeFactors(n);
    }
    return n;
}