char* minWindow(char* s, char* t) {
    int sLen = strlen(s), tLen = strlen(t);
    if (sLen < tLen) return "";

    int map[128] = {0}, count = 0, minLen = INT_MAX, start = 0, minStart = 0;

    for (int i = 0; i < tLen; i++) {
        map[t[i]]++;
    }

    for (int end = 0; end < sLen; end++) {
        if (map[s[end]] > 0) count++;
        map[s[end]]--;

        while (count == tLen) {
            if (minLen > end - start + 1) {
                minLen = end - start + 1;
                minStart = start;
            }
            map[s[start]]++;
            if (map[s[start]] > 0) count--;
            start++;
        }
    }

    if (minLen == INT_MAX) return "";

    char* result = (char*)malloc((minLen + 1) * sizeof(char));
    strncpy(result, s + minStart, minLen);
    result[minLen] = '\0';
    return result;
}