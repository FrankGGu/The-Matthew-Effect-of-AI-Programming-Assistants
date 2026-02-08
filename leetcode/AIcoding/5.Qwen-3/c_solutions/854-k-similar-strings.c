#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *str;
    int dist;
} Node;

typedef struct {
    char *data;
    int size;
} Queue;

void enqueue(Queue *q, char *str, int dist) {
    char *copy = (char *)malloc(strlen(str) + 1);
    strcpy(copy, str);
    q->data = (char *)realloc(q->data, (q->size + 1) * (strlen(str) + 1));
    strcpy(&q->data[q->size * (strlen(str) + 1)], copy);
    free(copy);
    q->size++;
}

char *dequeue(Queue *q) {
    char *result = &q->data[0];
    memmove(q->data, &q->data[(strlen(result) + 1)], (q->size - 1) * (strlen(result) + 1));
    q->size--;
    return result;
}

int isKSimilar(char *s, char *t) {
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] != t[i]) return 0;
    }
    return 1;
}

int getMinSwaps(char *s, char *t, int index) {
    int count = 0;
    for (int i = index; i < strlen(s); i++) {
        if (s[i] == t[index]) {
            char temp = s[index];
            s[index] = s[i];
            s[i] = temp;
            count++;
            break;
        }
    }
    return count;
}

int solve(char *s, char *t) {
    int len = strlen(s);
    int swaps = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] == t[i]) continue;
        for (int j = i + 1; j < len; j++) {
            if (s[j] == t[i] && s[i] == t[j]) {
                char temp = s[i];
                s[i] = s[j];
                s[j] = temp;
                swaps += 1;
                break;
            }
        }
        if (s[i] != t[i]) {
            for (int j = i + 1; j < len; j++) {
                if (s[j] == t[i]) {
                    char temp = s[i];
                    s[i] = s[j];
                    s[j] = temp;
                    swaps += 1;
                    break;
                }
            }
        }
    }
    return swaps;
}

int kSimilarStrings(char *s, char *t) {
    int len = strlen(s);
    if (len != strlen(t)) return -1;
    if (isKSimilar(s, t)) return 0;

    Queue q;
    q.data = NULL;
    q.size = 0;
    enqueue(&q, s, 0);

    char *visited = (char *)malloc(len * sizeof(char));
    memset(visited, 0, len * sizeof(char));

    while (q.size > 0) {
        char *current = dequeue(&q);
        int currentDist = 0;
        for (int i = 0; i < len; i++) {
            if (current[i] != t[i]) {
                for (int j = i + 1; j < len; j++) {
                    if (current[j] == t[i] && current[i] == t[j]) {
                        char *newStr = (char *)malloc(len + 1);
                        strcpy(newStr, current);
                        char temp = newStr[i];
                        newStr[i] = newStr[j];
                        newStr[j] = temp;
                        if (!visited[newStr]) {
                            visited[newStr] = 1;
                            enqueue(&q, newStr, currentDist + 1);
                        }
                        free(newStr);
                    }
                }
                for (int j = i + 1; j < len; j++) {
                    if (current[j] == t[i]) {
                        char *newStr = (char *)malloc(len + 1);
                        strcpy(newStr, current);
                        char temp = newStr[i];
                        newStr[i] = newStr[j];
                        newStr[j] = temp;
                        if (!visited[newStr]) {
                            visited[newStr] = 1;
                            enqueue(&q, newStr, currentDist + 1);
                        }
                        free(newStr);
                    }
                }
            }
        }
        free(current);
    }

    return -1;
}