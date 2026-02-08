int maxDeletions(int* A, int ASize) {
    int count[10001] = {0}, uniqueCount = 0;
    for (int i = 0; i < ASize; i++) {
        if (count[A[i]] == 0) uniqueCount++;
        count[A[i]]++;
    }

    int deletions = 0;
    for (int i = 10000; i >= 1; i--) {
        while (count[i] > 1) {
            deletions++;
            count[i]--;
            while (count[i] > 0) i--;
        }
    }

    return deletions;
}