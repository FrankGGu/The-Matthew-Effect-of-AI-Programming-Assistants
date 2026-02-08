#include <string.h>

int minMovesToMakePalindrome(char * s) {
    int n = strlen(s);
    int moves = 0;
    int left = 0;
    int right = n - 1;

    while (left < right) {
        if (s[left] == s[right]) {
            left++;
            right--;
        } else {
            int k = right;
            while (k > left && s[k] != s[left]) {
                k--;
            }

            if (k == left) {
                moves += (right - left) / 2;
                left++;
            } else {
                moves += (right - k);
                char char_to_move = s[k];
                for (int i = k; i < right; i++) {
                    s[i] = s[i+1];
                }
                s[right] = char_to_move;
                left++;
                right--;
            }
        }
    }
    return moves;
}