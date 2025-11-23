int numJewelsInStones(char * jewels, char * stones) {
    int count = 0;
    int jewelMap[128] = {0};

    for (int i = 0; jewels[i] != '\0'; i++) {
        jewelMap[jewels[i]] = 1;
    }

    for (int i = 0; stones[i] != '\0'; i++) {
        if (jewelMap[stones[i]]) {
            count++;
        }
    }

    return count;
}