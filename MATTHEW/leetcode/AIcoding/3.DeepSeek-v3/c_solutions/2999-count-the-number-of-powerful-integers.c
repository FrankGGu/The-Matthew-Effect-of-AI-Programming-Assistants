long long numberOfPowerfulInt(long long start, long long finish, int limit, char* s) {
    long long base = 1;
    int len_s = strlen(s);
    for (int i = 0; i < len_s; i++) {
        if (base > finish / 10 + 1) break;
        base *= 10;
    }

    long long count(long long x) {
        if (x < 0) return 0;
        char num[20];
        sprintf(num, "%lld", x);
        int n = strlen(num);

        long long dp[n][2];
        memset(dp, -1, sizeof(dp));

        long long dfs(int pos, int tight, int leading) {
            if (pos == n) return leading ? 0 : 1;
            if (dp[pos][tight] != -1 && !leading) return dp[pos][tight];

            long long res = 0;
            int up = tight ? num[pos] - '0' : 9;
            up = (up > limit) ? limit : up;

            if (leading) {
                res += dfs(pos + 1, 0, 1);
                for (int d = 1; d <= up; d++) {
                    res += dfs(pos + 1, tight && (d == num[pos] - '0'), 0);
                }
            } else {
                for (int d = 0; d <= up; d++) {
                    res += dfs(pos + 1, tight && (d == num[pos] - '0'), 0);
                }
            }

            if (!leading) dp[pos][tight] = res;
            return res;
        }

        long long total = dfs(0, 1, 1);

        if (x < base) return 0;
        long long prefix = x / base;
        long long suffix = x % base;

        long long count_prefix = 0;
        char pre_num[20];
        sprintf(pre_num, "%lld", prefix);
        int m = strlen(pre_num);

        long long dp2[m][2];
        memset(dp2, -1, sizeof(dp2));

        long long dfs2(int pos, int tight) {
            if (pos == m) return 1;
            if (dp2[pos][tight] != -1) return dp2[pos][tight];

            long long res = 0;
            int up = tight ? pre_num[pos] - '0' : 9;
            up = (up > limit) ? limit : up;

            for (int d = 0; d <= up; d++) {
                res += dfs2(pos + 1, tight && (d == pre_num[pos] - '0'));
            }

            return dp2[pos][tight] = res;
        }

        count_prefix = dfs2(0, 1);

        char s_num[20];
        strcpy(s_num, s);
        long long s_val = 0;
        for (int i = 0; i < len_s; i++) {
            s_val = s_val * 10 + (s_num[i] - '0');
        }

        if (suffix >= s_val) {
            return count_prefix;
        } else {
            return count_prefix - 1;
        }
    }

    return count(finish) - count(start - 1);
}