bool splitString(char * s) {
    int n = strlen(s);
    for (int len = 1; len <= n / 2; len++) {
        long long prev = -1;
        bool valid = true;
        for (int start = 0; start < n; start += len) {
            if (start + len > n) {
                valid = false;
                break;
            }
            char temp[len + 1];
            strncpy(temp, s + start, len);
            temp[len] = '\0';
            long long curr = atoll(temp);
            if (prev != -1 && curr != prev - 1) {
                valid = false;
                break;
            }
            prev = curr;
        }
        if (valid) return true;
    }
    return false;
}