#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int racecar(int target) {
    int queue[10000];
    int dist[10001];
    for (int i = 0; i <= target; i++) {
        dist[i] = -1;
    }

    int head = 0, tail = 0;
    queue[tail++] = 0;
    dist[0] = 0;

    while (head < tail) {
        int pos = queue[head++];
        int steps = dist[pos];

        // Accelerate
        int speed = 1;
        int new_pos = pos + speed;
        int num_moves = 1;
        while (abs(new_pos) <= 2 * target)
        {
            if (abs(new_pos - target) < target && new_pos >= 0 && new_pos <= target) {
                if (dist[new_pos] == -1) {
                    dist[new_pos] = steps + num_moves;
                    queue[tail++] = new_pos;
                }
            }
            speed *= 2;
            new_pos = pos + speed;
            num_moves++;
        }

        // Reverse
        speed = -1;
        new_pos = pos + speed;
        num_moves = 1;
         while (abs(new_pos) <= 2 * target)
        {
            if (abs(new_pos - target) < target && new_pos >= 0 && new_pos <= target) {
                if (dist[new_pos] == -1) {
                    dist[new_pos] = steps + num_moves;
                    queue[tail++] = new_pos;
                }
            }
            speed *= 2;
            new_pos = pos + speed;
             num_moves++;
        }

        if (dist[target] != -1) {
            return dist[target];
        }
    }

    return dist[target];
}