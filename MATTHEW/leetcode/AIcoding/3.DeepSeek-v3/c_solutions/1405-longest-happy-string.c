#define MAX_LEN 600

char* longestDiverseString(int a, int b, int c) {
    char* res = (char*)malloc((MAX_LEN + 1) * sizeof(char));
    int idx = 0;
    int total = a + b + c;
    int cnt[3] = {a, b, c};

    while (total > 0) {
        int max_i = -1;
        for (int i = 0; i < 3; i++) {
            if ((max_i == -1 || cnt[i] > cnt[max_i]) && 
                !(idx >= 2 && res[idx-1] == 'a' + i && res[idx-2] == 'a' + i)) {
                max_i = i;
            }
        }

        if (max_i == -1) break;

        if (idx >= 2 && res[idx-1] == 'a' + max_i && res[idx-2] == 'a' + max_i) {
            int second_i = -1;
            for (int i = 0; i < 3; i++) {
                if (i != max_i && cnt[i] > 0 && 
                    !(idx >= 2 && res[idx-1] == 'a' + i && res[idx-2] == 'a' + i)) {
                    if (second_i == -1 || cnt[i] > cnt[second_i]) {
                        second_i = i;
                    }
                }
            }
            if (second_i == -1) break;
            res[idx++] = 'a' + second_i;
            cnt[second_i]--;
            total--;
        } else {
            res[idx++] = 'a' + max_i;
            cnt[max_i]--;
            total--;
        }
    }

    res[idx] = '\0';
    return res;
}