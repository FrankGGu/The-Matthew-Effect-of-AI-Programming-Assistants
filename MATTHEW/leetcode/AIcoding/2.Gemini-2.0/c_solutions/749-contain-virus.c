#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int containVirus(int** isInfected, int isInfectedSize, int* isInfectedColSize) {
    int n = isInfectedSize;
    int m = isInfectedColSize[0];
    int ans = 0;

    while (true) {
        int max_threat = 0;
        int max_idx = -1;
        int walls_needed = 0;

        bool* visited = (bool*)calloc(n * m, sizeof(bool));
        int* regions_size = (int*)calloc(n * m, sizeof(int));
        int regions_count = 0;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (isInfected[i][j] == 1 && !visited[i * m + j]) {
                    int threat = 0;
                    int walls = 0;
                    int region_size = 0;

                    int* queue_x = (int*)malloc(n * m * sizeof(int));
                    int* queue_y = (int*)malloc(n * m * sizeof(int));
                    int head = 0, tail = 0;

                    queue_x[tail] = i;
                    queue_y[tail++] = j;
                    visited[i * m + j] = true;
                    region_size++;

                    while (head < tail) {
                        int x = queue_x[head];
                        int y = queue_y[head++];

                        for (int k = 0; k < 4; ++k) {
                            int nx = x + dx[k];
                            int ny = y + dy[k];

                            if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                                if (isInfected[nx][ny] == 0) {
                                    threat++;
                                    walls++;
                                } else if (isInfected[nx][ny] == 1 && !visited[nx * m + ny]) {
                                    queue_x[tail] = nx;
                                    queue_y[tail++] = ny;
                                    visited[nx * m + ny] = true;
                                    region_size++;
                                }
                            }
                        }
                    }

                    free(queue_x);
                    free(queue_y);

                    regions_size[regions_count] = region_size;

                    if (threat > max_threat) {
                        max_threat = threat;
                        max_idx = regions_count;
                        walls_needed = walls;
                    }
                    regions_count++;
                }
            }
        }

        free(visited);
        free(regions_size);

        if (max_idx == -1) {
            break;
        }

        ans += walls_needed;

        visited = (bool*)calloc(n * m, sizeof(bool));

        int region_idx = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (isInfected[i][j] == 1 && !visited[i * m + j]) {
                    if (region_idx == max_idx) {
                        int* queue_x = (int*)malloc(n * m * sizeof(int));
                        int* queue_y = (int*)malloc(n * m * sizeof(int));
                        int head = 0, tail = 0;

                        queue_x[tail] = i;
                        queue_y[tail++] = j;
                        visited[i * m + j] = true;
                        isInfected[i][j] = -1;

                        while (head < tail) {
                            int x = queue_x[head];
                            int y = queue_y[head++];

                            for (int k = 0; k < 4; ++k) {
                                int nx = x + dx[k];
                                int ny = y + dy[k];

                                if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                                    if (isInfected[nx][ny] == 1 && !visited[nx * m + ny]) {
                                        queue_x[tail] = nx;
                                        queue_y[tail++] = ny;
                                        visited[nx * m + ny] = true;
                                        isInfected[nx][ny] = -1;
                                    }
                                }
                            }
                        }
                        free(queue_x);
                        free(queue_y);

                    } else {
                        int* queue_x = (int*)malloc(n * m * sizeof(int));
                        int* queue_y = (int*)malloc(n * m * sizeof(int));
                        int head = 0, tail = 0;

                        queue_x[tail] = i;
                        queue_y[tail++] = j;
                        visited[i * m + j] = true;

                        while (head < tail) {
                            int x = queue_x[head];
                            int y = queue_y[head++];

                            for (int k = 0; k < 4; ++k) {
                                int nx = x + dx[k];
                                int ny = y + dy[k];

                                if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                                    if (isInfected[nx][ny] == 0) {
                                        isInfected[nx][ny] = 1;
                                    } else if (isInfected[nx][ny] == 1 && !visited[nx * m + ny]) {
                                        queue_x[tail] = nx;
                                        queue_y[tail++] = ny;
                                        visited[nx * m + ny] = true;
                                    }
                                }
                            }
                        }
                        free(queue_x);
                        free(queue_y);
                    }
                    region_idx++;
                }
            }
        }
        free(visited);

        bool infection_remaining = false;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (isInfected[i][j] == 1) {
                    infection_remaining = true;
                    break;
                }
            }
            if (infection_remaining) break;
        }
        if (!infection_remaining) break;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (isInfected[i][j] == -1) {
                    isInfected[i][j] = 1;
                }
            }
        }
    }

    return ans;
}