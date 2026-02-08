int sumNums(int n) {
    n > 0 && (n += sumNums(n - 1));
    return n;
}