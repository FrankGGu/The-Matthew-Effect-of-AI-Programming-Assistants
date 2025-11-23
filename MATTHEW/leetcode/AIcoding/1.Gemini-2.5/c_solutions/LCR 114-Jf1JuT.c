#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_CHARS 26

int adj[MAX_CHARS][MAX_CHARS];
int adj_count[MAX_CHARS];
int in_degree[MAX_CHARS];
bool present[MAX_CHARS];

int queue[MAX_CHARS];
int queue_front;
int queue_rear;

char* alienOrder(char** words, int wordsSize) {
    memset(adj, 0, sizeof(adj));
    memset(adj_count, 0, sizeof(adj_count));
    memset(in_degree, 0, sizeof(in_degree));
    memset(present, false, sizeof(present));

    queue_front = 0;
    queue_rear = 0;

    int total_unique_chars = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; words[i][j] != '\0'; j++) {
            int char_idx = words[i][j] - 'a';
            if (!present[char_idx]) {
                present[char_idx] = true;
                total_unique_chars++;
            }
        }
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char* s1 = words[i];
        char* s2 = words[i+1];
        int len1 = strlen(s1);
        int len2 = strlen(s2);

        int ptr1 = 0;
        int ptr2 = 0;
        bool found_diff = false;

        while (ptr1 < len1 && ptr2 < len2) {
            if (s1[ptr1] != s2[ptr2]) {
                int u = s1[ptr1] - 'a';
                int v = s2[ptr2] - 'a';

                bool edge_exists = false;
                for (int k = 0; k < adj_count[u]; k++) {
                    if (adj[u][k] == v) {
                        edge_exists = true;
                        break;
                    }
                }
                if (!edge_exists) {
                    adj[u][adj_count[u]++] = v;
                    in_degree[v]++;
                }
                found_diff = true;
                break;
            }
            ptr1++;
            ptr2++;
        }

        if (!found_diff && len1 > len2) {
            char* result = (char*)malloc(sizeof(char));
            result[0] = '\0';
            return result;
        }
    }

    for (int i = 0; i < MAX_CHARS; i++) {
        if (present[i] && in_degree[i] == 0) {
            queue[queue_rear++] = i;
        }
    }

    char* result_str = (char*)malloc((total_unique_chars + 1) * sizeof(char));
    int result_idx = 0;

    while (queue_front < queue_rear) {
        int u = queue[queue_front++];
        result_str[result_idx++] = (char)('a' + u);

        for (int i = 0; i < adj_count[u]; i++) {
            int v = adj[u][i];
            in_degree[v]--;
            if (in_degree[v] == 0) {
                queue[queue_rear++] = v;
            }
        }
    }

    if (result_idx != total_unique_chars) {
        free(result_str);
        char* empty_str = (char*)malloc(sizeof(char));
        empty_str[0] = '\0';
        return empty_str;
    }

    result_str[result_idx] = '\0';
    return result_str;
}