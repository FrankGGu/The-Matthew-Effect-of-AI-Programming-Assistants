typedef struct {
    int count[26];
    int max_len[26][3];
} State;

int maximumLength(char* s) {
    int n = strlen(s);
    State state = {0};
    int cur_len = 0;
    char last_char = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == last_char) {
            cur_len++;
        } else {
            cur_len = 1;
            last_char = s[i];
        }

        int idx = last_char - 'a';
        state.count[idx]++;

        if (cur_len > state.max_len[idx][0]) {
            state.max_len[idx][2] = state.max_len[idx][1];
            state.max_len[idx][1] = state.max_len[idx][0];
            state.max_len[idx][0] = cur_len;
        } else if (cur_len > state.max_len[idx][1]) {
            state.max_len[idx][2] = state.max_len[idx][1];
            state.max_len[idx][1] = cur_len;
        } else if (cur_len > state.max_len[idx][2]) {
            state.max_len[idx][2] = cur_len;
        }
    }

    int result = -1;
    for (int i = 0; i < 26; i++) {
        if (state.count[i] < 3) continue;

        int max1 = state.max_len[i][0];
        int max2 = state.max_len[i][1];
        int max3 = state.max_len[i][2];

        if (max1 >= 3) {
            result = fmax(result, max1 - 2);
        }
        if (max1 >= 2 && max2 >= 1) {
            result = fmax(result, fmin(max1 - 1, max2));
        }
        if (max3 >= 1) {
            result = fmax(result, max3);
        }
    }

    return result == 0 ? -1 : result;
}