bool canReach(char* s, int minJump, int maxJump) {
    int n = strlen(s);
    if (s[n-1] != '0') return false;

    int* dp = (int*)calloc(n, sizeof(int));
    int* pre = (int*)calloc(n, sizeof(int));

    dp[0] = 1;
    pre[0] = 1;

    for (int i = 1; i < n; i++) {
        if (s[i] == '0') {
            int left = i - maxJump;
            int right = i - minJump;

            if (right < 0) {
                dp[i] = 0;
            } else {
                left = left > 0 ? left : 0;
                int sum = pre[right] - (left > 0 ? pre[left-1] : 0);
                dp[i] = sum > 0 ? 1 : 0;
            }
        } else {
            dp[i] = 0;
        }

        pre[i] = pre[i-1] + dp[i];
    }

    bool result = dp[n-1];
    free(dp);
    free(pre);
    return result;
}