typedef unsigned long long ull;

char* longestDupSubstring(char* s) {
    int n = strlen(s);
    int left = 1, right = n;
    char* result = (char*)malloc(n + 1);
    result[0] = '\0';

    ull base = 26;
    ull mod = 1e9 + 7;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        ull hash = 0;
        ull power = 1;

        for (int i = 0; i < mid; i++) {
            hash = (hash * base + s[i] - 'a') % mod;
            power = (power * base) % mod;
        }

        ull* seen = (ull*)malloc(n * sizeof(ull));
        int seenSize = 0;
        int found = 0;
        int start = -1;

        seen[seenSize++] = hash;

        for (int i = mid; i < n; i++) {
            hash = (hash * base - (s[i - mid] - 'a') * power % mod + mod) % mod;
            hash = (hash + s[i] - 'a') % mod;

            int duplicate = 0;
            for (int j = 0; j < seenSize; j++) {
                if (seen[j] == hash) {
                    int match = 1;
                    for (int k = 0; k < mid; k++) {
                        if (s[i - mid + 1 + k] != s[seenSize - 1 - j + k]) {
                            match = 0;
                            break;
                        }
                    }
                    if (match) {
                        duplicate = 1;
                        start = i - mid + 1;
                        break;
                    }
                }
            }

            if (duplicate) {
                found = 1;
                break;
            }
            seen[seenSize++] = hash;
        }

        free(seen);

        if (found) {
            if (mid > strlen(result)) {
                strncpy(result, s + start, mid);
                result[mid] = '\0';
            }
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}