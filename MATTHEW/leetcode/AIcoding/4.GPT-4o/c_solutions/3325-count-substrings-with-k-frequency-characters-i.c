int countKSubstrings(char *s, int k) {
    int count = 0, n = strlen(s);
    int freq[26] = {0}, uniqueCount = 0, left = 0;

    for (int right = 0; right < n; right++) {
        if (++freq[s[right] - 'a'] == 1) uniqueCount++;

        while (uniqueCount > k) {
            if (--freq[s[left] - 'a'] == 0) uniqueCount--;
            left++;
        }

        if (uniqueCount == k) {
            int tempLeft = left;
            while (tempLeft < right && freq[s[tempLeft] - 'a'] > 1) tempLeft++;
            count += tempLeft - left + 1;
        }
    }

    return count;
}