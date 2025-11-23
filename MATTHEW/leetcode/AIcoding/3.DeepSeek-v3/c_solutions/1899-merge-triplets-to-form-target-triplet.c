int max(int a, int b) {
    return a > b ? a : b;
}

bool mergeTriplets(int** triplets, int tripletsSize, int* tripletsColSize, int* target, int targetSize) {
    int a = 0, b = 0, c = 0;

    for (int i = 0; i < tripletsSize; i++) {
        if (triplets[i][0] <= target[0] && triplets[i][1] <= target[1] && triplets[i][2] <= target[2]) {
            a = max(a, triplets[i][0]);
            b = max(b, triplets[i][1]);
            c = max(c, triplets[i][2]);
        }
    }

    return a == target[0] && b == target[1] && c == target[2];
}