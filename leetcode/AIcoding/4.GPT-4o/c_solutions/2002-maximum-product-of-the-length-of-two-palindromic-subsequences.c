int isPalindrome(char* s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) return 0;
        start++;
        end--;
    }
    return 1;
}

int maxProduct(char* s) {
    int n = strlen(s);
    int maxProd = 0;

    for (int i = 1; i < (1 << n); i++) {
        int len1 = 0, len2 = 0;
        char subseq1[100], subseq2[100];
        int index1 = 0, index2 = 0;

        for (int j = 0; j < n; j++) {
            if (i & (1 << j)) {
                subseq1[index1++] = s[j];
                len1++;
            } else {
                subseq2[index2++] = s[j];
                len2++;
            }
        }
        subseq1[index1] = '\0';
        subseq2[index2] = '\0';

        if (isPalindrome(subseq1, 0, len1 - 1) && isPalindrome(subseq2, 0, len2 - 1)) {
            maxProd = fmax(maxProd, len1 * len2);
        }
    }

    return maxProd;
}