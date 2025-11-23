#include <stdbool.h>
#include <string.h>

bool closeStrings(char *word1, char *word2) {
    int count1[26] = {0}, count2[26] = {0};
    bool char1[26] = {false}, char2[26] = {false};
    int len1 = strlen(word1), len2 = strlen(word2);

    if (len1 != len2) return false;

    for (int i = 0; i < len1; i++) {
        count1[word1[i] - 'a']++;
        count2[word2[i] - 'a']++;
        char1[word1[i] - 'a'] = true;
        char2[word2[i] - 'a'] = true;
    }

    for (int i = 0; i < 26; i++) {
        if (char1[i] != char2[i]) return false;
    }

    int freq1[26] = {0}, freq2[26] = {0};
    for (int i = 0; i < 26; i++) {
        if (count1[i] > 0) freq1[count1[i]]++;
        if (count2[i] > 0) freq2[count2[i]]++;
    }

    for (int i = 0; i < 26; i++) {
        if (freq1[i] != freq2[i]) return false;
    }

    return true;
}