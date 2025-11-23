char* shortestBeautifulSubstring(char* s, int k) {
    int n = strlen(s);
    int left = 0, count = 0;
    int min_len = n + 1;
    int start = -1;

    for (int right = 0; right < n; right++) {
        if (s[right] == '1') {
            count++;
        }

        while (count == k) {
            int current_len = right - left + 1;
            if (current_len < min_len) {
                min_len = current_len;
                start = left;
            } else if (current_len == min_len) {
                if (strncmp(s + start, s + left, min_len) > 0) {
                    start = left;
                }
            }

            if (s[left] == '1') {
                count--;
            }
            left++;
        }
    }

    if (start == -1) {
        return "";
    }

    char* result = (char*)malloc((min_len + 1) * sizeof(char));
    strncpy(result, s + start, min_len);
    result[min_len] = '\0';
    return result;
}