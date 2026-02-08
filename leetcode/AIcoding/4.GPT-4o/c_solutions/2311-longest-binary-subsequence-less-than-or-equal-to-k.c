int longestSubsequence(char * s, int k) {
    int n = strlen(s);
    int count = 0;
    long long num = 0;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '0') {
            count++;
        } else {
            if ((num | (1LL << count)) <= k) {
                num |= (1LL << count);
                count++;
            }
        }
    }

    return count;
}