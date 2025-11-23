bool checkDistances(char* s, int* distance, int distanceSize) {
    int first[26];
    for (int i = 0; i < 26; i++) {
        first[i] = -1;
    }

    for (int i = 0; s[i] != '\0'; i++) {
        int idx = s[i] - 'a';
        if (first[idx] == -1) {
            first[idx] = i;
        } else {
            int dist = i - first[idx] - 1;
            if (dist != distance[idx]) {
                return false;
            }
        }
    }

    return true;
}