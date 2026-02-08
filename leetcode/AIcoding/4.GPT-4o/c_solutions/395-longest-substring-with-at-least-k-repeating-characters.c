int longestSubstring(char * s, int k) {
    int n = strlen(s);
    if (n == 0 || k > n) return 0;

    int maxLength = 0;
    for (int uniqueTarget = 1; uniqueTarget <= 26; uniqueTarget++) {
        int count[26] = {0};
        int start = 0, end = 0, uniqueCount = 0, atLeastKCount = 0;

        while (end < n) {
            if (uniqueCount <= uniqueTarget) {
                int index = s[end] - 'a';
                if (count[index] == 0) uniqueCount++;
                count[index]++;
                if (count[index] == k) atLeastKCount++;
                end++;
            } else {
                int index = s[start] - 'a';
                if (count[index] == k) atLeastKCount--;
                count[index]--;
                if (count[index] == 0) uniqueCount--;
                start++;
            }

            if (uniqueCount == uniqueTarget && uniqueCount == atLeastKCount) {
                maxLength = fmax(maxLength, end - start);
            }
        }
    }
    return maxLength;
}