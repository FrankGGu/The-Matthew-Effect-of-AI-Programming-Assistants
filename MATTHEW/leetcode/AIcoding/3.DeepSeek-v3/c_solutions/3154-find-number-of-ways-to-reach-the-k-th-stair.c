int waysToReachStair(int k) {
    int res = 0;
    long long sum = 1;
    int jump = 1;

    while (sum <= k + 1) {
        if (sum >= k && sum - k <= jump) {
            int diff = (int)(sum - k);
            if (diff <= jump) {
                int n = jump - diff + 1;
                if (n > 0) {
                    res += n;
                }
            }
        }
        sum += (1LL << jump);
        jump++;
    }

    return res;
}