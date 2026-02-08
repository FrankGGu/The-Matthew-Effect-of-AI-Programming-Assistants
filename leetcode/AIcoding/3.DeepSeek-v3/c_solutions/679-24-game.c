double eps = 1e-6;

bool judgePoint24(double* cards, int cardsSize) {
    if (cardsSize == 1) {
        return fabs(cards[0] - 24) < eps;
    }

    for (int i = 0; i < cardsSize; i++) {
        for (int j = 0; j < cardsSize; j++) {
            if (i == j) continue;

            double next[4];
            int nextSize = 0;
            for (int k = 0; k < cardsSize; k++) {
                if (k != i && k != j) {
                    next[nextSize++] = cards[k];
                }
            }

            // Try all operations
            for (int op = 0; op < 4; op++) {
                if (op == 0) next[nextSize] = cards[i] + cards[j];
                else if (op == 1) next[nextSize] = cards[i] - cards[j];
                else if (op == 2) next[nextSize] = cards[i] * cards[j];
                else if (op == 3) {
                    if (fabs(cards[j]) < eps) continue;
                    next[nextSize] = cards[i] / cards[j];
                }

                if (judgePoint24(next, nextSize + 1)) {
                    return true;
                }
            }
        }
    }

    return false;
}

bool leetcode24Game(int* nums, int numsSize) {
    double cards[4];
    for (int i = 0; i < 4; i++) {
        cards[i] = (double)nums[i];
    }
    return judgePoint24(cards, 4);
}