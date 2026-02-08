int numJewelsInStones(char * jewels, char * stones) {
    int count = 0;
    int jewelMap[58] = {0}; // For 'A' to 'z'

    while (*jewels) {
        jewelMap[*jewels - 'A'] = 1;
        jewels++;
    }

    while (*stones) {
        if (jewelMap[*stones - 'A']) {
            count++;
        }
        stones++;
    }

    return count;
}