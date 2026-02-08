bool canRemove(char *s, char *p, int mid) {
    int s_len = strlen(s);
    int p_len = strlen(p);
    bool removed[s_len + 1];
    memset(removed, false, sizeof(removed));

    for (int i = 0; i < mid; i++) {
        removed[s[i] - 'a'] = true;
    }

    int j = 0;
    for (int i = 0; i < s_len; i++) {
        if (!removed[s[i] - 'a'] && s[i] == p[j]) {
            j++;
        }
        if (j == p_len) {
            return true;
        }
    }
    return j == p_len;
}

int maxRemovableCharacters(char *s, char *p, int k) {
    int left = 0, right = k, maxRemovals = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canRemove(s, p, mid)) {
            maxRemovals = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return maxRemovals;
}