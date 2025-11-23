function countPossibleSets(n) {
    return (1 << (n - 1)) - 1;
}