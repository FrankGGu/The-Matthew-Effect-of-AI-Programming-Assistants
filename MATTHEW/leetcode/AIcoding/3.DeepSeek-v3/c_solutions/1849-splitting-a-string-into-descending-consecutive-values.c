bool backtrack(char* s, int start, long long prev, int count) {
    if (start == strlen(s)) {
        return count > 1;
    }

    long long num = 0;
    for (int i = start; i < strlen(s); i++) {
        num = num * 10 + (s[i] - '0');

        if (num > prev && prev != -1) {
            break;
        }

        if (prev == -1 || num == prev - 1) {
            if (backtrack(s, i + 1, num, count + 1)) {
                return true;
            }
        }
    }
    return false;
}

bool splitString(char* s) {
    return backtrack(s, 0, -1, 0);
}