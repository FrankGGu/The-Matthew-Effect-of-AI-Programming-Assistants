#define MOD 10000000000LL

char * abbreviateProduct(int left, int right) {
    long long suf = 1;
    int zeros = 0;
    double pre = 1.0;

    for (int i = left; i <= right; i++) {
        pre *= i;
        suf *= i;

        while (pre >= 100000.0) {
            pre /= 10.0;
        }

        while (suf % 10 == 0) {
            zeros++;
            suf /= 10;
        }

        if (suf > MOD) {
            suf %= MOD;
        }
    }

    char *res = malloc(20 * sizeof(char));
    if (suf < 10000000000LL) {
        sprintf(res, "%llde%d", suf, zeros);
    } else {
        sprintf(res, "%05lld...%05llde%d", (long long)(pre), suf % 100000, zeros);
    }
    return res;
}