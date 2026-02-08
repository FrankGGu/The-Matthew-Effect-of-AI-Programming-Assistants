typedef long long ll;

int lengthAfterTransformations(char* s, int t) {
    int cnt[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        cnt[s[i] - 'a']++;
    }

    for (int i = 0; i < t; i++) {
        ll temp[26] = {0};
        for (int j = 0; j < 25; j++) {
            temp[j + 1] += cnt[j];
        }
        temp[0] += cnt[25];
        temp[1] += cnt[25];

        for (int j = 0; j < 26; j++) {
            cnt[j] = temp[j] % 1000000007;
        }
    }

    ll total = 0;
    for (int i = 0; i < 26; i++) {
        total += cnt[i];
    }
    return total % 1000000007;
}