bool isPossible(string s1, string s2) {
    int count1[26] = {0}, count2[26] = {0};
    for (char c : s1) count1[c - 'a']++;
    for (char c : s2) count2[c - 'a']++;

    int distinct1 = 0, distinct2 = 0;
    for (int i = 0; i < 26; i++) {
        if (count1[i] > 0) distinct1++;
        if (count2[i] > 0) distinct2++;
    }

    return (distinct1 == distinct2) || (distinct1 < distinct2 && distinct1 <= s1.length()) || (distinct2 < distinct1 && distinct2 <= s2.length());
}