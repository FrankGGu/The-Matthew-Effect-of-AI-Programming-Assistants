#include <string.h>
#include <stdbool.h>
#include <limits.h>

int minSubstring(string s) {
    int n = strlen(s);
    int result = INT_MAX;

    for (int i = 1; i <= 26; i++) {
        int count[26] = {0};
        int unique = 0;
        int valid = 0;

        for (int j = 0; j < n; j++) {
            int idx = s[j] - 'a';
            if (count[idx] == 0) unique++;
            count[idx]++;
            if (count[idx] == i) valid++;

            while (valid == unique) {
                result = fmin(result, j - i + 1);
                count[s[i] - 'a']--;
                if (count[s[i] - 'a'] == i - 1) valid--;
                if (count[s[i] - 'a'] == 0) unique--;
                i++;
            }
        }
    }

    return result == INT_MAX ? 0 : result;
}