#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumJumps(int forbidden[], int forbiddenSize, int a, int b, int x) {
    int max_reach = x + a + b;
    for (int i = 0; i < forbiddenSize; i++) {
        max_reach = fmax(max_reach, forbidden[i] + a + b);
    }
    max_reach += a + b;

    bool visited[2][max_reach + 1];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j <= max_reach; j++) {
            visited[i][j] = false;
        }
    }

    for (int i = 0; i < forbiddenSize; i++) {
        if (forbidden[i] <= max_reach) {
            visited[0][forbidden[i]] = true;
            visited[1][forbidden[i]] = true;
        }
    }

    int queue[100000][2];
    int head = 0, tail = 0;
    queue[tail][0] = 0;
    queue[tail][1] = 0;
    tail++;
    visited[0][0] = true;

    int steps = 0;
    while (head < tail) {
        int size = tail - head;
        for (int i = 0; i < size; i++) {
            int pos = queue[head][0];
            int back = queue[head][1];
            head++;

            if (pos == x) {
                return steps;
            }

            int forward = pos + a;
            if (forward <= max_reach && !visited[0][forward]) {
                queue[tail][0] = forward;
                queue[tail][1] = 0;
                tail++;
                visited[0][forward] = true;
            }

            if (back == 0) {
                int backward = pos - b;
                if (backward >= 0 && !visited[1][backward]) {
                    queue[tail][0] = backward;
                    queue[tail][1] = 1;
                    tail++;
                    visited[1][backward] = true;
                }
            }
        }
        steps++;
    }

    return -1;
}