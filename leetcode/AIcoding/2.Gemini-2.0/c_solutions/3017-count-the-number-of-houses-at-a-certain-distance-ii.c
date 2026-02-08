#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* countOfPairs(int n, int x, int y, int** edges, int edgesSize, int* edgesColSize) {
    long long* ans = (long long*)calloc(n, sizeof(long long));
    int* dist = (int*)malloc(n * sizeof(int));
    int i, j, u, v, d;

    x--; 
    y--;

    for (i = 0; i < n; i++) {
        dist[i] = 0;
    }

    for (i = 0; i < n; i++) {
        for (j = i + 1; j < n; j++) {

            int shortest_path = abs(i - j);

            d = abs(i - x) + abs(j - y) + 1;
            if (d < shortest_path)
            {
                shortest_path = d;
            }
            d = abs(i - y) + abs(j - x) + 1;
            if (d < shortest_path)
            {
                shortest_path = d;
            }

            for (int k = 0; k < edgesSize; k++) {
                u = edges[k][0] - 1;
                v = edges[k][1] - 1;

                int temp = 0;

                int path1 = abs(i - u) + abs(j - v) + 1;
                if (path1 < shortest_path)
                {
                    shortest_path = path1;
                }
                path1 = abs(i - v) + abs(j - u) + 1;
                if (path1 < shortest_path)
                {
                    shortest_path = path1;
                }
            }

            dist[shortest_path - 1]++;
        }
    }

    for (i = 0; i < n; i++)
    {
        ans[i] = dist[i] * 2;
    }

    free(dist);
    return ans;
}