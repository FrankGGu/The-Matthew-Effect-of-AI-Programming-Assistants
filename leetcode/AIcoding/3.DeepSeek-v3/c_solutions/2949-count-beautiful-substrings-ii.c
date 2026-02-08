typedef long long ll;

bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

long long beautifulSubstrings(char* s, int k) {
    int n = strlen(s);

    int m = 1;
    while (1) {
        if ((m * m) % (4 * k) == 0) {
            break;
        }
        m++;
    }

    ll result = 0;
    int balance = 0;

    int mod = 2 * m;
    int* seen = (int*)malloc(sizeof(int) * (2 * n + 1) * mod);
    memset(seen, 0, sizeof(int) * (2 * n + 1) * mod);

    seen[n * mod + 0] = 1;

    for (int i = 0; i < n; i++) {
        if (isVowel(s[i])) {
            balance++;
        } else {
            balance--;
        }

        int target_mod = (i + 1) % mod;
        result += seen[balance * mod + target_mod];
        seen[balance * mod + target_mod]++;
    }

    free(seen);
    return result;
}