int reinitializePermutation(int n) {
    int count = 0, perm = 1;
    do {
        int temp = perm;
        perm = (temp % 2) * (n / 2) + (temp / 2);
        count++;
    } while (perm != 1);
    return count;
}