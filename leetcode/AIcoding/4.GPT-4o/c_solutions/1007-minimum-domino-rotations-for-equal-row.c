int minDominoRotations(int* A, int ASize, int* B, int BSize) {
    for (int x = 1; x <= 6; x++) {
        int rotA = 0, rotB = 0, valid = 1;
        for (int i = 0; i < ASize; i++) {
            if (A[i] != x && B[i] != x) {
                valid = 0;
                break;
            }
            if (A[i] != x) rotA++;
            if (B[i] != x) rotB++;
        }
        if (valid) {
            int minRot = rotA < rotB ? rotA : rotB;
            return minRot;
        }
    }
    return -1;
}