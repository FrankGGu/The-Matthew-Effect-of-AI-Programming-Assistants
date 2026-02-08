double factorial(int n) {
    double res = 1.0;
    for (int i = 2; i <= n; i++) {
        res *= i;
    }
    return res;
}

double total = 0.0;
double valid = 0.0;

void backtrack(int* balls, int ballsSize, int idx, int sum1, int sum2, int* box1, int* box2, double comb1, double comb2) {
    if (idx == ballsSize) {
        if (sum1 != sum2) return;

        double ways1 = comb1;
        double ways2 = comb2;
        total += ways1 * ways2;

        int distinct1 = 0, distinct2 = 0;
        for (int i = 0; i < ballsSize; i++) {
            if (box1[i] > 0) distinct1++;
            if (box2[i] > 0) distinct2++;
        }
        if (distinct1 == distinct2) {
            valid += ways1 * ways2;
        }
        return;
    }

    for (int i = 0; i <= balls[idx]; i++) {
        int j = balls[idx] - i;
        if (sum1 + i > sum2 + j) break;

        box1[idx] = i;
        box2[idx] = j;

        double new_comb1 = comb1 / factorial(i);
        double new_comb2 = comb2 / factorial(j);

        backtrack(balls, ballsSize, idx + 1, sum1 + i, sum2 + j, box1, box2, new_comb1, new_comb2);
    }
}

double getProbability(int* balls, int ballsSize) {
    total = 0.0;
    valid = 0.0;

    int totalBalls = 0;
    for (int i = 0; i < ballsSize; i++) {
        totalBalls += balls[i];
    }

    double comb = 1.0;
    for (int i = 1; i <= totalBalls; i++) {
        comb *= i;
    }
    for (int i = 0; i < ballsSize; i++) {
        comb /= factorial(balls[i]);
    }

    int* box1 = (int*)calloc(ballsSize, sizeof(int));
    int* box2 = (int*)calloc(ballsSize, sizeof(int));

    backtrack(balls, ballsSize, 0, 0, 0, box1, box2, comb, comb);

    free(box1);
    free(box2);

    return valid / total;
}