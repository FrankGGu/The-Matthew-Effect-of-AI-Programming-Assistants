int numTilePossibilities(char * tiles) {
    int count = 0;
    int n = strlen(tiles);
    int *used = (int *)calloc(n, sizeof(int));

    void backtrack(int depth) {
        count++;
        for (int i = 0; i < n; i++) {
            if (used[i] || (i > 0 && tiles[i] == tiles[i - 1] && !used[i - 1])) continue;
            used[i] = 1;
            backtrack(depth + 1);
            used[i] = 0;
        }
    }

    qsort(tiles, n, sizeof(char), cmp);
    backtrack(0);
    free(used);
    return count - 1;
}

int cmp(const void *a, const void *b) {
    return (*(char *)a - *(char *)b);
}