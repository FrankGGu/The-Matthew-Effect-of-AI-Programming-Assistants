int numberOfSubstring(char * s) {
    int count[3] = {0}, res = 0, left = 0, n = strlen(s);
    for (int right = 0; right < n; right++) {
        count[s[right] - 'a']++;
        while (count[0] > 0 && count[1] > 0 && count[2] > 0) {
            count[s[left] - 'a']--;
            left++;
        }
        res += left;
    }
    return res;
}