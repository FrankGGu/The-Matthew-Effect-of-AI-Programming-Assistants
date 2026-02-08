int minimumSwaps(char *s1, char *s2) {
    int n = strlen(s1);
    int x = 0, y = 0;

    for (int i = 0; i < n; i++) {
        if (s1[i] != s2[i]) {
            if (s1[i] == 'x') x++;
            else y++;
        }
    }

    if ((x + y) % 2 != 0) return -1;
    return x / 2 + y / 2 + (x % 2) * 2; 
}