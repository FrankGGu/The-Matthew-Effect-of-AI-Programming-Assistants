/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
bool checkInclusion(char* s1, char* s2) {
    int len1 = strlen(s1), len2 = strlen(s2);
    if (len1 > len2) return false;

    int count1[26] = {0};
    int count2[26] = {0};

    for (int i = 0; i < len1; i++) {
        count1[s1[i] - 'a']++;
        count2[s2[i] - 'a']++;
    }

    int matches = 0;
    for (int i = 0; i < 26; i++) {
        if (count1[i] == count2[i]) matches++;
    }

    for (int i = len1; i < len2; i++) {
        if (matches == 26) return true;

        int left = s2[i - len1] - 'a';
        int right = s2[i] - 'a';

        count2[right]++;
        if (count2[right] == count1[right]) matches++;
        else if (count2[right] == count1[right] + 1) matches--;

        count2[left]--;
        if (count2[left] == count1[left]) matches++;
        else if (count2[left] == count1[left] - 1) matches--;
    }

    return matches == 26;
}