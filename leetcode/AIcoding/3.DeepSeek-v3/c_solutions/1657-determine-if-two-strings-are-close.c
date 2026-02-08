#include <string.h>
#include <stdbool.h>

bool closeStrings(char* word1, char* word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);

    if (len1 != len2) {
        return false;
    }

    int freq1[26] = {0};
    int freq2[26] = {0};

    for (int i = 0; i < len1; i++) {
        freq1[word1[i] - 'a']++;
        freq2[word2[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if ((freq1[i] == 0 && freq2[i] != 0) || (freq1[i] != 0 && freq2[i] == 0)) {
            return false;
        }
    }

    int count1[100001] = {0};
    int count2[100001] = {0};

    for (int i = 0; i < 26; i++) {
        if (freq1[i] > 0) {
            count1[freq1[i]]++;
        }
        if (freq2[i] > 0) {
            count2[freq2[i]]++;
        }
    }

    for (int i = 1; i < 100001; i++) {
        if (count1[i] != count2[i]) {
            return false;
        }
    }

    return true;
}