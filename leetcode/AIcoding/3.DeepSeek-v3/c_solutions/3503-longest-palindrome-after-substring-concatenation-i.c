int longestPalindrome(char* s, char* t) {
    int s_len = strlen(s);
    int t_len = strlen(t);
    int max_len = 0;

    for (int i = 0; i < s_len; i++) {
        for (int j = 0; j < t_len; j++) {
            int left = i, right = j;
            int len = 0;
            while (left >= 0 && right < t_len && s[left] == t[right]) {
                len += 2;
                left--;
                right++;
            }
            if (len > max_len) max_len = len;
        }
    }

    for (int i = 0; i < s_len; i++) {
        int left = i, right = i;
        int len = 1;
        while (left >= 0 && right < s_len && s[left] == s[right]) {
            len = (left == right) ? 1 : len + 2;
            left--;
            right++;
        }
        if (len > max_len) max_len = len;
    }

    for (int i = 0; i < t_len; i++) {
        int left = i, right = i;
        int len = 1;
        while (left >= 0 && right < t_len && t[left] == t[right]) {
            len = (left == right) ? 1 : len + 2;
            left--;
            right++;
        }
        if (len > max_len) max_len = len;
    }

    for (int i = 0; i < s_len; i++) {
        for (int j = 0; j < t_len; j++) {
            int left = i, right = j;
            int len = 0;
            while (left >= 0 && right < t_len && s[left] == t[right]) {
                len += 2;
                left--;
                right++;
                if (left >= 0 && right < t_len && s[left] == t[right]) {
                    int inner_len = 1;
                    int inner_left = left, inner_right = right;
                    while (inner_left >= 0 && inner_right < t_len && s[inner_left] == t[inner_right]) {
                        inner_len = (inner_left == inner_right) ? 1 : inner_len + 2;
                        inner_left--;
                        inner_right++;
                    }
                    if (len + inner_len > max_len) max_len = len + inner_len;
                }
            }
        }
    }

    return max_len;
}