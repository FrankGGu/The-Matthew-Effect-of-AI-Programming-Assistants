#include <string.h>
#include <stdbool.h>

bool checkPartitioning(char * s) {
    int n = strlen(s);

    if (n < 3) {
        return false;
    }

    bool isPalindrome[n][n];

    for (int i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
    }

    for (int i = 0; i < n - 1; i++) {
        isPalindrome[i][i+1] = (s[i] == s[i+1]);
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            isPalindrome[i][j] = (s[i] == s[j] && isPalindrome[i+1][j-1]);
        }
    }

    for (int i = 0; i <= n - 3; i++) {
        if (!isPalindrome[0][i]) {
            continue;
        }

        for (int j = i + 1; j <= n - 2; j++) {
            if (isPalindrome[i+1][j] && isPalindrome[j+1][n-1]) {
                return true;
            }
        }
    }

    return false;
}