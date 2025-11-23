char *takeCharacters(char *s, int k, int* returnSize) {
    int n = strlen(s);
    int count[26] = {0};
    for (int i = 0; i < n; i++) count[s[i] - 'a']++;

    int left = 0, right = 0, required = 0;
    while (required < 26 && right < n) {
        if (count[s[right] - 'a'] < k) required++;
        count[s[right] - 'a']--;
        right++;
    }

    int maxLength = right;
    while (right < n) {
        while (left < right && count[s[left] - 'a'] < 0) {
            count[s[left] - 'a']++;
            left++;
        }
        if (required < 26) {
            maxLength = fmax(maxLength, right - left);
        }
        count[s[right] - 'a']--;
        if (count[s[right] - 'a'] < k) required++;
        right++;
    }

    char *result = (char *)malloc((maxLength + 1) * sizeof(char));
    strncpy(result, s + left, maxLength);
    result[maxLength] = '\0';
    *returnSize = maxLength;
    return result;
}