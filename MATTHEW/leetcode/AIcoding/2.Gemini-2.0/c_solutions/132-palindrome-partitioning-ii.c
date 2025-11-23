#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCut(char * s){
    int n = strlen(s);
    bool isPalindrome[n][n];
    int cuts[n];

    for (int i = 0; i < n; i++) {
        cuts[i] = i;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            isPalindrome[i][j] = false;
        }
    }

    for (int i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i+1]) {
            isPalindrome[i][i+1] = true;
        }
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j] && isPalindrome[i+1][j-1]) {
                isPalindrome[i][j] = true;
            }
        }
    }

    for (int i = 1; i < n; i++) {
        if (isPalindrome[0][i]) {
            cuts[i] = 0;
        } else {
            for (int j = 0; j < i; j++) {
                if (isPalindrome[j+1][i]) {
                    cuts[i] = (cuts[i] < cuts[j] + 1) ? cuts[i] : (cuts[j] + 1);
                }
            }
        }
    }

    return cuts[n-1];
}