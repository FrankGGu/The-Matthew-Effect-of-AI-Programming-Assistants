int nthUglyNumber(int n) {
    int *ugly = (int*)malloc(n * sizeof(int));
    ugly[0] = 1;
    int i2 = 0, i3 = 0, i5 = 0;
    int next2 = 2, next3 = 3, next5 = 5;

    for (int i = 1; i < n; i++) {
        int next = next2 < next3 ? next2 : next3;
        next = next < next5 ? next : next5;
        ugly[i] = next;

        if (next == next2) {
            i2++;
            next2 = ugly[i2] * 2;
        }
        if (next == next3) {
            i3++;
            next3 = ugly[i3] * 3;
        }
        if (next == next5) {
            i5++;
            next5 = ugly[i5] * 5;
        }
    }

    int result = ugly[n-1];
    free(ugly);
    return result;
}