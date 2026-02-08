int numTilePossibilities(char* tiles) {
    int count[26] = {0};
    for (int i = 0; tiles[i]; i++) {
        count[tiles[i] - 'A']++;
    }
    return dfs(count);
}

int dfs(int* count) {
    int sum = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] == 0) continue;
        sum++;
        count[i]--;
        sum += dfs(count);
        count[i]++;
    }
    return sum;
}