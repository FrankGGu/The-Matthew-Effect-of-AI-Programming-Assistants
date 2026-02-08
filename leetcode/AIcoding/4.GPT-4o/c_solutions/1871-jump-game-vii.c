bool canReach(char *s, int minJump, int maxJump) {
    int n = strlen(s);
    if (s[0] == '1' || s[n - 1] == '1') return false;

    int farthest = 0, reach = 0;
    for (int i = 0; i < n; i++) {
        if (i > farthest) return false;
        if (s[i] == '0') {
            if (i >= minJump) {
                reach = fmax(reach, i + maxJump);
            }
            if (i >= farthest) {
                farthest = reach;
            }
        }
    }
    return true;
}