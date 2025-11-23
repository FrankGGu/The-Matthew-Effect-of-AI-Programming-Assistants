int countTime(char *time) {
    int count = 0;

    for (int h = 0; h < 24; ++h) {
        for (int m = 0; m < 60; ++m) {
            int h1 = h / 10;
            int h2 = h % 10;
            int m1 = m / 10;
            int m2 = m % 10;

            int hour_match = 1;
            if (time[0] != '?' && (time[0] - '0') != h1) {
                hour_match = 0;
            }
            if (time[1] != '?' && (time[1] - '0') != h2) {
                hour_match = 0;
            }

            int minute_match = 1;
            if (time[3] != '?' && (time[3] - '0') != m1) {
                minute_match = 0;
            }
            if (time[4] != '?' && (time[4] - '0') != m2) {
                minute_match = 0;
            }

            if (hour_match && minute_match) {
                count++;
            }
        }
    }

    return count;
}