int longestCommonPrefix(char** strs, int strsSize, int k) {
    int n = strsSize;
    if (n == 0) return 0;

    int minLen = strlen(strs[0]);
    for (int i = 1; i < n; i++) {
        int len = strlen(strs[i]);
        if (len < minLen) minLen = len;
    }

    int left = 0, right = minLen;
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int match = 1;
                for (int p = 0; p < mid; p++) {
                    if (strs[i][p] != strs[j][p]) {
                        match = 0;
                        break;
                    }
                }
                if (match) count++;
                if (count >= k) break;
            }
            if (count >= k) break;
        }

        if (count >= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}