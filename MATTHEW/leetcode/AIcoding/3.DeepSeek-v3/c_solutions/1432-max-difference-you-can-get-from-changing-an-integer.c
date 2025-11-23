int maxDiff(int num) {
    char s1[10], s2[10];
    sprintf(s1, "%d", num);
    sprintf(s2, "%d", num);

    int len = strlen(s1);

    for (int i = 0; i < len; i++) {
        if (s1[i] != '9') {
            char x = s1[i];
            for (int j = i; j < len; j++) {
                if (s1[j] == x) {
                    s1[j] = '9';
                }
            }
            break;
        }
    }

    if (s2[0] != '1') {
        char x = s2[0];
        for (int j = 0; j < len; j++) {
            if (s2[j] == x) {
                s2[j] = '1';
            }
        }
    } else {
        for (int i = 1; i < len; i++) {
            if (s2[i] != '0' && s2[i] != '1') {
                char x = s2[i];
                for (int j = i; j < len; j++) {
                    if (s2[j] == x) {
                        s2[j] = '0';
                    }
                }
                break;
            }
        }
    }

    int a = atoi(s1);
    int b = atoi(s2);
    return a - b;
}