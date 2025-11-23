int minNumberOfFrogs(char* croakOfFrogs) {
    int c = 0, r = 0, o = 0, a = 0, k = 0;
    int frogs = 0, max_frogs = 0;

    for (int i = 0; croakOfFrogs[i] != '\0'; i++) {
        char ch = croakOfFrogs[i];

        if (ch == 'c') {
            c++;
            frogs++;
            if (frogs > max_frogs) max_frogs = frogs;
        } else if (ch == 'r') {
            if (c <= 0) return -1;
            c--;
            r++;
        } else if (ch == 'o') {
            if (r <= 0) return -1;
            r--;
            o++;
        } else if (ch == 'a') {
            if (o <= 0) return -1;
            o--;
            a++;
        } else if (ch == 'k') {
            if (a <= 0) return -1;
            a--;
            k++;
            frogs--;
        } else {
            return -1;
        }
    }

    if (c != 0 || r != 0 || o != 0 || a != 0) return -1;
    return max_frogs;
}