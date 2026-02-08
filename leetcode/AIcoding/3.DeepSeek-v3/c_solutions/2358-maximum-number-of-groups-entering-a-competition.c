int maximumGroups(int* grades, int gradesSize) {
    int k = 0;
    long total = 0;
    while (total + k + 1 <= gradesSize) {
        k++;
        total += k;
    }
    return k;
}