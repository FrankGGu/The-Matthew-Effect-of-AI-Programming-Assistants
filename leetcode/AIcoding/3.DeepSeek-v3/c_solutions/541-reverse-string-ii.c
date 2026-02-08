void reverse(char* s, int start, int end) {
    while (start < end) {
        char temp = s[start];
        s[start] = s[end];
        s[end] = temp;
        start++;
        end--;
    }
}

char* reverseStr(char* s, int k) {
    int n = strlen(s);
    for (int i = 0; i < n; i += 2 * k) {
        if (i + k <= n) {
            reverse(s, i, i + k - 1);
        } else {
            reverse(s, i, n - 1);
        }
    }
    return s;
}