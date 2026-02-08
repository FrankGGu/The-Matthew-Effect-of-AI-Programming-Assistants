int findTheLongestSubstring(char* s) {
    int state = 0;
    int map[32];
    for (int i = 0; i < 32; i++) map[i] = -2;
    map[0] = -1;
    int max_len = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        switch (s[i]) {
            case 'a': state ^= 1; break;
            case 'e': state ^= 2; break;
            case 'i': state ^= 4; break;
            case 'o': state ^= 8; break;
            case 'u': state ^= 16; break;
        }
        if (map[state] == -2) {
            map[state] = i;
        } else {
            if (i - map[state] > max_len) {
                max_len = i - map[state];
            }
        }
    }
    return max_len;
}