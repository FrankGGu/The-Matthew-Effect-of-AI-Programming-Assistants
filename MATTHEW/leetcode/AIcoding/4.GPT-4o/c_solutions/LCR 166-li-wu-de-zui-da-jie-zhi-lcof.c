int numJewelsInStones(char * jewels, char * stones) {
    int jewelCount = 0;
    int jewelMap[128] = {0};

    for (int i = 0; jewels[i] != '\0'; i++) {
        jewelMap[(int)jewels[i]] = 1;
    }

    for (int i = 0; stones[i] != '\0'; i++) {
        jewelCount += jewelMap[(int)stones[i]];
    }

    return jewelCount;
}