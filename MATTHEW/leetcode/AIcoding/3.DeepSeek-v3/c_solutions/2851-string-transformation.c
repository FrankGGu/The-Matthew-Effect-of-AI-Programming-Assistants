#include <string.h>
#include <stdbool.h>

bool canConvert(char* str1, char* str2) {
    if (strcmp(str1, str2) == 0) return true;

    int n = strlen(str1);
    char mapping[26];
    for (int i = 0; i < 26; i++) mapping[i] = '\0';

    for (int i = 0; i < n; i++) {
        int idx1 = str1[i] - 'a';
        int idx2 = str2[i] - 'a';

        if (mapping[idx1] == '\0') {
            mapping[idx1] = str2[i];
        } else if (mapping[idx1] != str2[i]) {
            return false;
        }
    }

    bool used[26] = {false};
    for (int i = 0; i < 26; i++) {
        if (mapping[i] != '\0') {
            used[mapping[i] - 'a'] = true;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (!used[i]) return true;
    }

    return false;
}