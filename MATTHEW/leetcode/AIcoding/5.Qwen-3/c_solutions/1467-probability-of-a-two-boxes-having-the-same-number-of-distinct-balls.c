#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double fact(int n) {
    if (n == 0) return 1.0;
    double res = 1.0;
    for (int i = 1; i <= n; i++) res *= i;
    return res;
}

double comb(int n, int k) {
    if (k > n || k < 0) return 0.0;
    return fact(n) / (fact(k) * fact(n - k));
}

double prob(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];

    double totalWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        totalWays += fact(balls[i]);
    }

    double sameWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        if (balls[i] == 0) continue;
        int cnt = balls[i];
        sameWays += fact(cnt);
    }

    return sameWays / totalWays;
}

double count(int* balls, int ballsSize, int idx, int b1, int b2, int d1, int d2, double* memo) {
    if (idx == ballsSize) {
        return (b1 == b2 && d1 == d2) ? 1.0 : 0.0;
    }

    int key = idx * 100000 + b1 * 1000 + b2 * 100 + d1 * 10 + d2;
    if (memo[key] != -1.0) return memo[key];

    double res = 0.0;
    int cnt = balls[idx];
    for (int take = 0; take <= cnt; take++) {
        int rem = cnt - take;
        int newB1 = b1 + take;
        int newB2 = b2 + rem;
        int newD1 = d1 + (take > 0 ? 1 : 0);
        int newD2 = d2 + (rem > 0 ? 1 : 0);
        res += comb(cnt, take) * count(balls, ballsSize, idx + 1, newB1, newB2, newD1, newD2, memo);
    }

    memo[key] = res;
    return res;
}

double query(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];

    double totalWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        totalWays += fact(balls[i]);
    }

    double sameWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        if (balls[i] == 0) continue;
        int cnt = balls[i];
        sameWays += fact(cnt);
    }

    return sameWays / totalWays;
}

double solution(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];

    double totalWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        totalWays += fact(balls[i]);
    }

    double sameWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        if (balls[i] == 0) continue;
        int cnt = balls[i];
        sameWays += fact(cnt);
    }

    return sameWays / totalWays;
}

double numberOfWays(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];

    double totalWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        totalWays += fact(balls[i]);
    }

    double sameWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        if (balls[i] == 0) continue;
        int cnt = balls[i];
        sameWays += fact(cnt);
    }

    return sameWays / totalWays;
}

double sum(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];
    return total;
}

double solve(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];

    double totalWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        totalWays += fact(balls[i]);
    }

    double sameWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        if (balls[i] == 0) continue;
        int cnt = balls[i];
        sameWays += fact(cnt);
    }

    return sameWays / totalWays;
}

double probabilityOfSameNumber(int* balls, int ballsSize) {
    int total = 0;
    for (int i = 0; i < ballsSize; i++) total += balls[i];

    double totalWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        totalWays += fact(balls[i]);
    }

    double sameWays = 0.0;
    for (int i = 0; i < ballsSize; i++) {
        if (balls[i] == 0) continue;
        int cnt = balls[i];
        sameWays += fact(cnt);
    }

    return sameWays / totalWays;
}