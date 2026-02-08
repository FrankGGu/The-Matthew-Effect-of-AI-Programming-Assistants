typedef long long ll;

int isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

long long countOfSubstrings(char* word, int k) {
    int n = strlen(word);
    ll res = 0;

    for (int t = 0; t < 2; t++) {
        int left = 0;
        int cnt[5] = {0};
        int cons = 0;
        int vowels = 0;

        for (int right = 0; right < n; right++) {
            char c = word[right];
            if (isVowel(c)) {
                int idx;
                if (c == 'a') idx = 0;
                else if (c == 'e') idx = 1;
                else if (c == 'i') idx = 2;
                else if (c == 'o') idx = 3;
                else idx = 4;

                if (cnt[idx] == 0) vowels++;
                cnt[idx]++;
            } else {
                cons++;
            }

            while (cons > k || (t == 0 && cons >= k)) {
                char lc = word[left];
                if (isVowel(lc)) {
                    int idx;
                    if (lc == 'a') idx = 0;
                    else if (lc == 'e') idx = 1;
                    else if (lc == 'i') idx = 2;
                    else if (lc == 'o') idx = 3;
                    else idx = 4;

                    cnt[idx]--;
                    if (cnt[idx] == 0) vowels--;
                } else {
                    cons--;
                }
                left++;
            }

            if (vowels == 5 && cons == k) {
                int temp = left;
                int temp_cnt[5];
                memcpy(temp_cnt, cnt, sizeof(cnt));
                int temp_cons = cons;
                int temp_vowels = vowels;

                while (temp_vowels == 5 && temp_cons == k) {
                    char lc = word[temp];
                    if (isVowel(lc)) {
                        int idx;
                        if (lc == 'a') idx = 0;
                        else if (lc == 'e') idx = 1;
                        else if (lc == 'i') idx = 2;
                        else if (lc == 'o') idx = 3;
                        else idx = 4;

                        temp_cnt[idx]--;
                        if (temp_cnt[idx] == 0) temp_vowels--;
                    } else {
                        temp_cons--;
                    }
                    temp++;
                }

                res += temp - left;
            }
        }
    }

    return res;
}