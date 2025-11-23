int checkInclusion(char * s1, char * s2) {
    int len1 = strlen(s1), len2 = strlen(s2);
    if (len1 > len2) return 0;

    int count1[26] = {0}, count2[26] = {0};

    for (int i = 0; i < len1; i++) {
        count1[s1[i] - 'a']++;
        count2[s2[i] - 'a']++;
    }

    if (memcmp(count1, count2, sizeof(count1)) == 0) return 1;

    for (int i = len1; i < len2; i++) {
        count2[s2[i] - 'a']++;
        count2[s2[i - len1] - 'a']--;
        if (memcmp(count1, count2, sizeof(count1)) == 0) return 1;
    }

    return 0;
}