bool buddyStrings(char * A, char * B) {
    int lenA = strlen(A), lenB = strlen(B);
    if (lenA != lenB) return false;

    if (A == B) {
        int count[26] = {0};
        for (int i = 0; i < lenA; i++) {
            count[A[i] - 'a']++;
            if (count[A[i] - 'a'] > 1) return true;
        }
        return false;
    }

    int first = -1, second = -1;
    for (int i = 0; i < lenA; i++) {
        if (A[i] != B[i]) {
            if (first == -1) first = i;
            else if (second == -1) second = i;
            else return false;
        }
    }

    return second != -1 && A[first] == B[second] && A[second] == B[first];
}