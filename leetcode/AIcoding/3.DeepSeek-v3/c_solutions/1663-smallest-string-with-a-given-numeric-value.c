char* getSmallestString(int n, int k) {
    char* res = (char*)malloc((n + 1) * sizeof(char));
    res[n] = '\0';

    for (int i = n - 1; i >= 0; i--) {
        int add = (k - i) > 26 ? 26 : (k - i);
        res[i] = 'a' + add - 1;
        k -= add;
    }

    return res;
}