int countCompleteSubstrings(char* word, int k) {
    int n = strlen(word);
    int res = 0;

    for (int i = 0; i < n; ) {
        int j = i + 1;
        while (j < n && abs(word[j] - word[j-1]) <= 2) {
            j++;
        }

        for (int len = 1; len <= 26; len++) {
            int window = len * k;
            if (window > j - i) break;

            int count[26] = {0};
            int good = 0;

            for (int m = i; m < i + window; m++) {
                int idx = word[m] - 'a';
                count[idx]++;
                if (count[idx] == k) good++;
                else if (count[idx] == k + 1) good--;
            }

            if (good == len) res++;

            for (int m = i + window; m < j; m++) {
                int out_idx = word[m - window] - 'a';
                int in_idx = word[m] - 'a';

                if (count[out_idx] == k) good--;
                count[out_idx]--;
                if (count[out_idx] == k) good++;

                if (count[in_idx] == k) good--;
                count[in_idx]++;
                if (count[in_idx] == k) good++;

                if (good == len) res++;
            }
        }

        i = j;
    }

    return res;
}