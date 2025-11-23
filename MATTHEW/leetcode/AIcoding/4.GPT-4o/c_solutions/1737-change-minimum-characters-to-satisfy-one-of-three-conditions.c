int minimumChanges(char *a, char *b) {
    int countA[26] = {0}, countB[26] = {0};
    int lenA = strlen(a), lenB = strlen(b);
    for (int i = 0; i < lenA; i++) countA[a[i] - 'a']++;
    for (int i = 0; i < lenB; i++) countB[b[i] - 'a']++;

    int totalChanges = lenA + lenB;
    for (int i = 0; i < 26; i++) {
        int changes = lenA + lenB - countA[i] - countB[i];
        totalChanges = fmin(totalChanges, changes);
    }

    for (int i = 0; i < 26; i++) {
        int changes = lenB - countB[i];
        totalChanges = fmin(totalChanges, changes + lenA);
        changes = lenA - countA[i];
        totalChanges = fmin(totalChanges, changes + lenB);
    }

    return totalChanges;
}