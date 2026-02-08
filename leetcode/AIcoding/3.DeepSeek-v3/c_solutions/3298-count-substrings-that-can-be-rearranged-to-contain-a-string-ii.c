typedef long long ll;

int count(char* s, int len, int k, int* freq, int* window) {
    int left = 0;
    int have = 0;
    int total = 0;

    for (int right = 0; right < len; right++) {
        char c = s[right];
        window[c - 'a']++;
        if (window[c - 'a'] == freq[c - 'a']) {
            have++;
        }

        while (have == k) {
            total += len - right;
            char leftChar = s[left];
            if (window[leftChar - 'a'] == freq[leftChar - 'a']) {
                have--;
            }
            window[leftChar - 'a']--;
            left++;
        }
    }
    return total;
}

long long countSubstrings(char* word, char* pattern) {
    int n = strlen(word);
    int m = strlen(pattern);

    int freq[26] = {0};
    int k = 0;
    for (int i = 0; i < m; i++) {
        int idx = pattern[i] - 'a';
        if (freq[idx] == 0) k++;
        freq[idx]++;
    }

    ll ans = 0;
    int window[26] = {0};

    ans += count(word, n, k, freq, window);

    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            freq[i]--;
            if (freq[i] == 0) k--;

            memset(window, 0, sizeof(window));
            ans += count(word, n, k, freq, window);

            if (freq[i] == 0) k++;
            freq[i]++;
        }
    }

    return ans;
}