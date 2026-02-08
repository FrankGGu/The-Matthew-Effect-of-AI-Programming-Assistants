int cook(int a, int b, int c) {
    int time = 0;
    while (a > 0 || b > 0 || c > 0) {
        if (a > 0) {
            a--;
            time++;
        }
        if (b > 0) {
            b--;
            time++;
        }
        if (c > 0) {
            c--;
            time++;
        }
    }
    return time;
}