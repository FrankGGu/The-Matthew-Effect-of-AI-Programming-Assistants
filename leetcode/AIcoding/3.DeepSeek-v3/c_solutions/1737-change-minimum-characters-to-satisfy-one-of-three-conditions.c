int minCharacters(char* a, char* b) {
    int countA[26] = {0};
    int countB[26] = {0};
    int lenA = strlen(a);
    int lenB = strlen(b);

    for (int i = 0; i < lenA; i++) countA[a[i] - 'a']++;
    for (int i = 0; i < lenB; i++) countB[b[i] - 'a']++;

    int total = lenA + lenB;
    int minChanges = total;

    for (int i = 0; i < 26; i++) {
        minChanges = fmin(minChanges, total - (countA[i] + countB[i]));
    }

    int sumA = 0, sumB = 0;
    for (int i = 0; i < 25; i++) {
        sumA += countA[i];
        sumB += countB[i];
        minChanges = fmin(minChanges, lenA - sumA + sumB);
        minChanges = fmin(minChanges, lenB - sumB + sumA);
    }

    return minChanges;
}