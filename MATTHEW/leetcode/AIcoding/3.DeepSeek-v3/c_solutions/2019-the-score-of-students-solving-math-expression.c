int scoreOfStudents(char* s, int* answers, int answersSize) {
    int n = strlen(s);
    int numCount = (n + 1) / 2;

    // Calculate correct answer
    int correct = 0;
    int* nums = malloc(numCount * sizeof(int));
    char* ops = malloc((numCount - 1) * sizeof(char));

    int idx_num = 0, idx_op = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            nums[idx_num++] = s[i] - '0';
        } else {
            ops[idx_op++] = s[i];
        }
    }

    // Handle multiplication first
    for (int i = 0; i < idx_op; i++) {
        if (ops[i] == '*') {
            nums[i + 1] = nums[i] * nums[i + 1];
            nums[i] = -1; // mark as used
        }
    }

    // Handle addition
    int sum = 0;
    for (int i = 0; i < numCount; i++) {
        if (nums[i] != -1) {
            sum += nums[i];
        }
    }
    correct = sum;

    // DP for all possible results
    int dp[numCount][numCount];
    for (int i = 0; i < numCount; i++) {
        for (int j = 0; j < numCount; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < numCount; i++) {
        dp[i][i] = 1 << (s[i * 2] - '0');
    }

    for (int len = 2; len <= numCount; len++) {
        for (int i = 0; i <= numCount - len; i++) {
            int j = i + len - 1;
            for (int k = i; k < j; k++) {
                char op = s[k * 2 + 1];
                int left = dp[i][k];
                int right = dp[k + 1][j];

                for (int l = 0; l <= 1000; l++) {
                    if ((left >> l) & 1) {
                        for (int r = 0; r <= 1000; r++) {
                            if ((right >> r) & 1) {
                                int res;
                                if (op == '+') {
                                    res = l + r;
                                } else {
                                    res = l * r;
                                }
                                if (res <= 1000) {
                                    dp[i][j] |= (1 << res);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    int possible = dp[0][numCount - 1];

    int score = 0;
    for (int i = 0; i < answersSize; i++) {
        int ans = answers[i];
        if (ans == correct) {
            score += 5;
        } else if (ans <= 1000 && (possible >> ans) & 1) {
            score += 2;
        }
    }

    free(nums);
    free(ops);
    return score;
}