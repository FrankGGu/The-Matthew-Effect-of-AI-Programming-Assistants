int* diStringMatch(char* S, int* returnSize) {
    int n = strlen(S);
    int* perm = (int*)malloc((n + 1) * sizeof(int));
    int low = 0, high = n;

    for (int i = 0; i < n; i++) {
        if (S[i] == 'I') {
            perm[i] = low++;
        } else {
            perm[i] = high--;
        }
    }
    perm[n] = low; // or high, both are equal at this point
    *returnSize = n + 1;
    return perm;
}