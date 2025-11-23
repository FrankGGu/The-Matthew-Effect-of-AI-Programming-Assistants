bool checkDistances(char * s, int* distance, int distanceSize) {
    int lastIndex[26] = {-1};
    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        if (lastIndex[index] == -1) {
            lastIndex[index] = i;
        } else {
            if (i - lastIndex[index] - 1 != distance[index]) {
                return false;
            }
            lastIndex[index] = i;
        }
    }
    return true;
}