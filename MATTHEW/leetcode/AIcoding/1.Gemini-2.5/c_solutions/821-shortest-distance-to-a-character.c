#include <stdlib.h>
#include <string.h>

int* shortestToChar(char* s, char c, int* returnSize) {
    int n = strlen(s);
    int* answer = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int last_c_index = -n;

    // First pass: left to right
    // Calculate distance to the nearest 'c' on the left or at the current position
    for (int i = 0; i < n; i++) {
        if (s[i] == c) {
            last_c_index = i;
        }
        answer[i] = i - last_c_index;
    }

    last_c_index = 2 * n; // A value larger than any possible index

    // Second pass: right to left
    // Calculate distance to the nearest 'c' on the right
    // And take the minimum of the current distance (from left) and this new distance (from right)
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == c) {
            last_c_index = i;
        }
        int dist_to_right_c = last_c_index - i;
        if (dist_to_right_c < answer[i]) {
            answer[i] = dist_to_right_c;
        }
    }

    return answer;
}