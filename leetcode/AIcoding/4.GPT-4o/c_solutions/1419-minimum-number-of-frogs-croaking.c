int minNumberOfFrogs(char *croakOfFrogs) {
    int count[5] = {0}, maxFrogs = 0;
    char *croak = "croak";

    for (int i = 0; croakOfFrogs[i]; i++) {
        int index = strchr(croak, croakOfFrogs[i]) - croak;
        if (index < 0 || index > 4) return -1;

        if (index == 0) {
            count[0]++;
            maxFrogs = fmax(maxFrogs, count[0]);
        } else {
            if (count[index] < count[index - 1]) {
                count[index]++;
            } else {
                return -1;
            }
        }
    }

    if (count[0] == count[4]) return maxFrogs;
    return -1;
}