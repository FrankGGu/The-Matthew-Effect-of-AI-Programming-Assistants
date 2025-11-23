/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* getGoodIndices(int** variables, int variablesSize, int* variablesColSize, int target, int* returnSize) {
    int* result = (int*)malloc(variablesSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < variablesSize; i++) {
        int a = variables[i][0];
        int b = variables[i][1];
        int c = variables[i][2];
        int m = variables[i][3];

        // First modular exponentiation: (a^b mod 10)
        int first = 1;
        a %= 10;
        while (b > 0) {
            if (b & 1) {
                first = (first * a) % 10;
            }
            a = (a * a) % 10;
            b >>= 1;
        }

        // Second modular exponentiation: (first^c mod m)
        int second = 1;
        first %= m;
        while (c > 0) {
            if (c & 1) {
                second = (second * first) % m;
            }
            first = (first * first) % m;
            c >>= 1;
        }

        if (second == target) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}