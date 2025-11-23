int minimumDamage(int* A, int ASize, int* B, int BSize) {
    int damage = 0;
    for (int i = 0; i < ASize; i++) {
        for (int j = 0; j < BSize; j++) {
            if (A[i] > B[j]) {
                damage += A[i] - B[j];
            }
        }
    }
    return damage;
}