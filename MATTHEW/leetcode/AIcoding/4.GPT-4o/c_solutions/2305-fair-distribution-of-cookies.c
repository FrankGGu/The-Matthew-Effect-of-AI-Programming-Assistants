int distributeCookies(int* cookies, int cookiesSize, int k) {
    int ans = INT_MAX;
    int* child = (int*)calloc(k, sizeof(int));

    void backtrack(int index, int* child, int k, int* cookies, int cookiesSize) {
        if (index == cookiesSize) {
            int maxCookies = 0;
            for (int i = 0; i < k; i++) {
                if (child[i] > maxCookies) {
                    maxCookies = child[i];
                }
            }
            ans = (maxCookies < ans) ? maxCookies : ans;
            return;
        }

        for (int i = 0; i < k; i++) {
            child[i] += cookies[index];
            backtrack(index + 1, child, k, cookies, cookiesSize);
            child[i] -= cookies[index];
            if (child[i] == 0) break;
        }
    }

    backtrack(0, child, k, cookies, cookiesSize);
    free(child);
    return ans;
}