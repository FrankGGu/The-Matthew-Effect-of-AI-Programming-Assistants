bool areAlmostEqual(char *s1, char *s2) {
    int diffCount = 0;
    char first1 = '\0', first2 = '\0', second1 = '\0', second2 = '\0';

    for (int i = 0; s1[i] != '\0'; i++) {
        if (s1[i] != s2[i]) {
            diffCount++;
            if (diffCount == 1) {
                first1 = s1[i];
                first2 = s2[i];
            } else if (diffCount == 2) {
                second1 = s1[i];
                second2 = s2[i];
            } else {
                return false;
            }
        }
    }

    if (diffCount == 0) return true;
    if (diffCount == 2 && first1 == second2 && first2 == second1) return true;
    return false;
}