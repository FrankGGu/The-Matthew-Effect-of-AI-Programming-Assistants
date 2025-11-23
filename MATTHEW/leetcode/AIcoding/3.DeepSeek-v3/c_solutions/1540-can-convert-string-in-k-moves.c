bool canConvertString(char* s, char* t, int k) {
    int len_s = strlen(s);
    int len_t = strlen(t);
    if (len_s != len_t) return false;

    int shifts[26] = {0};

    for (int i = 0; i < len_s; i++) {
        int diff = t[i] - s[i];
        if (diff < 0) diff += 26;
        if (diff > 0) {
            if (diff + shifts[diff] * 26 > k) {
                return false;
            }
            shifts[diff]++;
        }
    }

    return true;
}