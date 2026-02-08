int minimumTime(char * cars, int n) {
    int time = 0;
    for (int i = 0; i < n; i++) {
        if (cars[i] == '1') {
            time += 2;
        } else {
            time += 1;
        }
    }
    return time;
}