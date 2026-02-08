#define ll long long

int maxProduct(char* s) {
    int n = strlen(s);
    int *len = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) len[i] = 0;

    int l = 0, r = -1;
    for (int i = 0; i < n; i++) {
        int k = (i > r) ? 1 : fmin(len[l + r - i], r - i + 1);
        while (i - k >= 0 && i + k < n && s[i - k] == s[i + k]) k++;
        len[i] = k;
        if (i + k - 1 > r) {
            l = i - k + 1;
            r = i + k - 1;
        }
    }

    int *left = (int*)malloc(n * sizeof(int));
    int *right = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        left[i] = 0;
        right[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int llen = len[i] * 2 - 1;
        int start = i - len[i] + 1;
        int end = i + len[i] - 1;
        left[end] = fmax(left[end], llen);
        right[start] = fmax(right[start], llen);
    }

    for (int i = n - 2; i >= 0; i--) {
        left[i] = fmax(left[i], left[i + 1] - 2);
    }
    for (int i = 1; i < n; i++) {
        left[i] = fmax(left[i], left[i - 1]);
    }

    for (int i = 1; i < n; i++) {
        right[i] = fmax(right[i], right[i - 1] - 2);
    }
    for (int i = n - 2; i >= 0; i--) {
        right[i] = fmax(right[i], right[i + 1]);
    }

    int res = 0;
    for (int i = 0; i < n - 1; i++) {
        res = fmax(res, left[i] * right[i + 1]);
    }

    free(len);
    free(left);
    free(right);
    return res;
}