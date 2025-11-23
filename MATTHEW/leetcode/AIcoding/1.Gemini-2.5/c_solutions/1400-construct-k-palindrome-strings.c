#include <stdbool.h>
#include <string.h>

bool canConstruct(char * s, int k){
    int n = strlen(s);

    if (k > n) {
        return false;
    }

    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int odd_count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            odd_count++;
        }
    }

    if (k < odd_count) {
        return false;
    }

    return true;
}