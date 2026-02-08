int longestSubstring(char * s, int k){
    int n = strlen(s);
    if (n == 0 || k > n) return 0;
    if (k <= 1) return n;

    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int mid = 0;
    while (mid < n && count[s[mid] - 'a'] >= k) {
        mid++;
    }
    if (mid == n) return n;

    int left = longestSubstring(s, k);
    int right = longestSubstring(s + mid + 1, k);

    return fmax(left, right);
}