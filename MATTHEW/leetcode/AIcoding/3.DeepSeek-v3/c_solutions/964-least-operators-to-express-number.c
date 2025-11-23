int leastOpsExpressTarget(int x, int target) {
    int pos = 0, neg = 0, k;
    for (k = 0; target > 0; k++, target /= x) {
        int cur = target % x;
        if (k == 0) {
            pos = cur * 2;
            neg = (x - cur) * 2;
        } else {
            int pos2 = fmin(cur * k + pos, (cur + 1) * k + neg);
            int neg2 = fmin((x - cur) * k + pos, (x - cur - 1) * k + neg);
            pos = pos2;
            neg = neg2;
        }
    }
    return fmin(pos, k + neg) - 1;
}