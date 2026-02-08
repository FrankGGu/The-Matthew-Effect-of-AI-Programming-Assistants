int fourSumCount(int* A, int ASize, int* B, int BSize, int* C, int CSize, int* D, int DSize) {
    int count = 0;
    int hash[2001] = {0}; // Hash table to store sums from A and B

    for (int i = 0; i < ASize; i++) {
        for (int j = 0; j < BSize; j++) {
            hash[A[i] + B[j] + 1000]++; // Store sums in the hash table
        }
    }

    for (int i = 0; i < CSize; i++) {
        for (int j = 0; j < DSize; j++) {
            count += hash[-(C[i] + D[j]) + 1000]; // Check for complements
        }
    }

    return count;
}