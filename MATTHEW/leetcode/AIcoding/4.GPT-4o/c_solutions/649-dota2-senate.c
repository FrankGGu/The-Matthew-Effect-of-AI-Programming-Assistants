char * predictPartyVictory(char * senate) {
    int radiant = 0, dire = 0, len = strlen(senate);
    for (int i = 0; i < len; i++) {
        if (senate[i] == 'R') radiant++;
        else dire++;
    }

    int rIndex = 0, dIndex = 0;
    while (radiant > 0 && dire > 0) {
        if (senate[rIndex] == 'R') {
            dIndex++;
            while (dIndex < len && senate[dIndex % len] != 'D') dIndex++;
            if (dIndex < len) {
                senate[dIndex % len] = '0';
                dire--;
            }
        } else {
            rIndex++;
            while (rIndex < len && senate[rIndex % len] != 'R') rIndex++;
            if (rIndex < len) {
                senate[rIndex % len] = '0';
                radiant--;
            }
        }
    }

    return radiant > 0 ? "Radiant" : "Dire";
}