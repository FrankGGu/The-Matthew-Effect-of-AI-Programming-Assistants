#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteComponents(int n, int** edges, int edgesSize, int* edgesColSize) {
    int count = 0;
    bool visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = false;
    }

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int nodes = 0;
            int edges_in_component = 0;
            int queue[n];
            int front = 0, rear = 0;
            queue[rear++] = i;
            visited[i] = true;
            nodes++;

            while (front < rear) {
                int u = queue[front++];
                for (int j = 0; j < edgesSize; j++) {
                    if (edges[j][0] == u && !visited[edges[j][1]]) {
                        queue[rear++] = edges[j][1];
                        visited[edges[j][1]] = true;
                        nodes++;
                    } else if (edges[j][1] == u && !visited[edges[j][0]]) {
                        queue[rear++] = edges[j][0];
                        visited[edges[j][0]] = true;
                        nodes++;
                    }
                }
            }

            for (int j = 0; j < edgesSize; j++) {
                bool found_u = false;
                bool found_v = false;
                int u = edges[j][0];
                int v = edges[j][1];

                int temp_front = 0;
                int temp_rear = 0;
                int temp_queue[n];

                temp_queue[temp_rear++] = i;

                bool temp_visited[n];
                for (int k = 0; k < n; k++) {
                    temp_visited[k] = false;
                }
                temp_visited[i] = true;

                while (temp_front < temp_rear) {
                    int curr = temp_queue[temp_front++];
                    if (curr == u) found_u = true;
                    if (curr == v) found_v = true;

                    for (int k = 0; k < edgesSize; k++) {
                        if (edges[k][0] == curr && !temp_visited[edges[k][1]]) {
                            temp_queue[temp_rear++] = edges[k][1];
                            temp_visited[edges[k][1]] = true;
                        } else if (edges[k][1] == curr && !temp_visited[edges[k][0]]) {
                            temp_queue[temp_rear++] = edges[k][0];
                            temp_visited[edges[k][0]] = true;
                        }
                    }
                }

                if (found_u && found_v) {
                    edges_in_component++;
                }
            }

            edges_in_component /= 2;
            if (edges_in_component == (nodes * (nodes - 1)) / 2) {
                count++;
            }
        }
    }

    return count;
}