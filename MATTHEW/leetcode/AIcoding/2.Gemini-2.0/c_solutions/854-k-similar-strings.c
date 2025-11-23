#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kSimilarity(char *s1, char *s2) {
    int n = strlen(s1);
    int queue[n * n];
    int dist[n * n];
    int head = 0, tail = 0;

    memset(dist, -1, sizeof(dist));

    int start_state = 0;
    for (int i = 0; i < n; i++) {
        start_state = start_state * 256 + s1[i];
    }

    queue[tail++] = start_state;
    dist[start_state] = 0;

    while (head < tail) {
        int curr_state = queue[head++];
        char curr_str[n + 1];
        int temp = curr_state;
        for (int i = n - 1; i >= 0; i--) {
            curr_str[i] = temp % 256;
            temp /= 256;
        }
        curr_str[n] = '\0';

        if (strcmp(curr_str, s2) == 0) {
            return dist[curr_state];
        }

        for (int i = 0; i < n; i++) {
            if (curr_str[i] != s2[i]) {
                for (int j = i + 1; j < n; j++) {
                    if (curr_str[j] == s2[i] && curr_str[j] != s2[j]) {
                        char next_str[n + 1];
                        strcpy(next_str, curr_str);
                        char temp_char = next_str[i];
                        next_str[i] = next_str[j];
                        next_str[j] = temp_char;

                        int next_state = 0;
                        for (int k = 0; k < n; k++) {
                            next_state = next_state * 256 + next_str[k];
                        }

                        if (dist[next_state] == -1) {
                            dist[next_state] = dist[curr_state] + 1;
                            queue[tail++] = next_state;
                        }
                    }
                }
                break;
            }
        }
    }

    return -1;
}