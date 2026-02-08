#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

#define MAX_LEN 1000

typedef struct {
    char str[MAX_LEN];
    int steps;
} Node;

int kSimilarity(char *A, char *B) {
    int len = strlen(A);
    bool visited[1 << 20] = {false};
    Node queue[MAX_LEN];
    int front = 0, rear = 0;

    strcpy(queue[rear++].str, A);
    visited[0] = true;

    while (front < rear) {
        Node current = queue[front++];
        if (strcmp(current.str, B) == 0) return current.steps;

        for (int i = 0; i < len; i++) {
            if (current.str[i] == B[i]) continue;
            for (int j = i + 1; j < len; j++) {
                if (current.str[j] == B[i] && current.str[j] != B[j]) {
                    char temp = current.str[i];
                    current.str[i] = current.str[j];
                    current.str[j] = temp;

                    int mask = 0;
                    for (int k = 0; k < len; k++) {
                        mask |= (current.str[k] != B[k]) << k;
                    }

                    if (!visited[mask]) {
                        visited[mask] = true;
                        queue[rear++] = (Node){ .steps = current.steps + 1 };
                        strcpy(queue[rear - 1].str, current.str);
                    }
                    current.str[j] = temp;
                }
            }
            break;  // We want to swap only the first mismatch
        }
    }
    return -1;
}