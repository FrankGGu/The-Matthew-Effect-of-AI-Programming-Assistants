long long wonderfulSubstrings(char* word) {
    int count[1024] = {0};
    count[0] = 1;
    long long result = 0;
    int mask = 0;

    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        mask ^= (1 << idx);

        result += count[mask];

        for (int j = 0; j < 10; j++) {
            result += count[mask ^ (1 << j)];
        }

        count[mask]++;
    }

    return result;
}