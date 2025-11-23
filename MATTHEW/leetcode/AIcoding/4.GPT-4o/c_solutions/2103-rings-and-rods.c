int countPoints(char * rings) {
    int rods[10] = {0};
    for (int i = 0; rings[i] != '\0'; i += 2) {
        int color = rings[i] == 'R' ? 1 : (rings[i] == 'G' ? 2 : 4);
        int rod = rings[i + 1] - '0';
        rods[rod] |= color;
    }
    int count = 0;
    for (int i = 0; i < 10; i++) {
        if (rods[i] == 7) count++;
    }
    return count;
}