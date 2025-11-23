#define MOD 1000000007

int createSortedArray(int* instructions, int instructionsSize) {
    int maxVal = 0;
    for (int i = 0; i < instructionsSize; i++) {
        if (instructions[i] > maxVal) {
            maxVal = instructions[i];
        }
    }

    long long* count = (long long*)calloc(maxVal + 2, sizeof(long long));
    long long result = 0;

    for (int i = 0; i < instructionsSize; i++) {
        long long smaller = 0, larger = 0;

        for (int j = 1; j < instructions[i]; j++) {
            smaller += count[j];
        }
        for (int j = instructions[i] + 1; j <= maxVal + 1; j++) {
            larger += count[j];
        }

        result = (result + smaller < MOD) ? (result + smaller) : (result + smaller) % MOD;
        count[instructions[i]]++;
    }

    free(count);
    return result % MOD;
}