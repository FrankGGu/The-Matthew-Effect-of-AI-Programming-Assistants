#include <stdbool.h>
#include <string.h>

bool checkStrings(char * s1, char * s2) {
    int n = strlen(s1);

    int freq1_even[26] = {0};
    int freq1_odd[26] = {0};
    int freq2_even[26] = {0};
    int freq2_odd[26] = {0};

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            freq1_even[s1[i] - 'a']++;
            freq2_even[s2[i] - 'a']++;
        } else {
            freq1_odd[s1[i] - 'a']++;
            freq2_odd[s2[i] - 'a']++;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (freq1_even[i] != freq2_even[i]) {
            return false;
        }
        if (freq1_odd[i] != freq2_odd[i]) {
            return false;
        }
    }

    return true;
}