bool checkPalindromeFormation(char* a, char* b) {
    int n = strlen(a);
    int i = 0, j = n - 1;

    while (i < j && a[i] == b[j]) {
        i++;
        j--;
    }
    if (i >= j) return true;

    int i1 = i, j1 = j;
    while (i1 < j1 && a[i1] == a[j1]) {
        i1++;
        j1--;
    }
    if (i1 >= j1) return true;

    i1 = i, j1 = j;
    while (i1 < j1 && b[i1] == b[j1]) {
        i1++;
        j1--;
    }
    if (i1 >= j1) return true;

    i = 0, j = n - 1;
    while (i < j && b[i] == a[j]) {
        i++;
        j--;
    }
    if (i >= j) return true;

    i1 = i, j1 = j;
    while (i1 < j1 && a[i1] == a[j1]) {
        i1++;
        j1--;
    }
    if (i1 >= j1) return true;

    i1 = i, j1 = j;
    while (i1 < j1 && b[i1] == b[j1]) {
        i1++;
        j1--;
    }
    if (i1 >= j1) return true;

    return false;
}