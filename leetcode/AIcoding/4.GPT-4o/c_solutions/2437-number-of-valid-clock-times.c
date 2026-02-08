int countTime(char *time) {
    int count = 0;

    for (int h = 0; h < 24; ++h) {
        for (int m = 0; m < 60; ++m) {
            char buffer[6];
            snprintf(buffer, sizeof(buffer), "%02d:%02d", h, m);
            int valid = 1;
            for (int i = 0; i < 5; ++i) {
                if (time[i] != '?' && time[i] != buffer[i]) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                count++;
            }
        }
    }

    return count;
}