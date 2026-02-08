#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double factorial(int n) {
    double res = 1.0;
    for (int i = 2; i <= n; i++)
        res *= i;
    return res;
}

double combination(int n, int k) {
    if (k < 0 || k > n) return 0.0;
    if (k == 0 || k == n) return 1.0;
    if (k > n / 2) k = n - k;
    double res = 1.0;
    for (int i = 1; i <= k; i++) {
        res = res * (n - i + 1) / i;
    }
    return res;
}

double getProbability(int* balls, int ballsSize, int totalBalls) {
    double totalWays = 0.0;
    double favorableWays = 0.0;
    int half = totalBalls / 2;

    double totalCombinations = combination(totalBalls, half);

    void backtrack(int index, int sum1, int sum2, double prod1, double prod2) {
        if (index == ballsSize) {
            if (sum1 == half) {
                totalWays += prod1 * prod2;
                if (sum1 == sum2)
                    favorableWays += prod1 * prod2;
            }
            return;
        }

        for (int i = 0; i <= balls[index]; i++) {
            if (sum1 + i <= half) {
                backtrack(index + 1, sum1 + i, sum2 + balls[index] - i, prod1 * combination(balls[index], i), prod2 * combination(balls[index], balls[index] - i));
            }
        }
    }

    double prod1 = 1.0;
    double prod2 = 1.0;
    for(int i = 0; i < ballsSize; i++){
        prod1 *= factorial(balls[i]);
        prod2 *= factorial(balls[i]);
    }

    backtrack(0, 0, 0, 1.0, 1.0);

    return favorableWays / totalWays;
}