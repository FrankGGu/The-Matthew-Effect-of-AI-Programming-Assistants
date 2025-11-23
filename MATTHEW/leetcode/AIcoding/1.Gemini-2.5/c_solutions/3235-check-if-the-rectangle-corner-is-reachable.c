#include <stdbool.h>
#include <stdlib.h>

static int* parent_arr;

int find_set(int v) {
    if (v == parent_arr[v])
        return v;
    return parent_arr[v] = find_set(parent_arr[v]);
}

void union_sets(int a, int b) {
    a = find_set(a);
    b = find_set(b);
    if (a != b)
        parent_arr[b] = a;
}

bool canReach(int x, int y, int** circles, int circlesSize, int* circlesColSize) {
    int num_dsu_nodes = circlesSize + 2; // 0: start (bottom/left), 1..circlesSize: circles, circlesSize+1: end (top/right)
    parent_arr = (int*)malloc(num_dsu_nodes * sizeof(int));

    for (int i = 0; i < num_dsu_nodes; ++i) {
        parent_arr[i] = i;
    }

    for (int i = 0; i < circlesSize; ++i) {
        long long r = circles[i][2];
        long long cx = circles[i][0];
        long long cy = circles[i][1];

        if (cy - r <= 0 || cx - r <= 0) {
            union_sets(0, i + 1);
        }

        if (cy + r >= y || cx + r >= x) {
            union_sets(circlesSize + 1, i + 1);
        }
    }

    for (int i = 0; i < circlesSize; ++i) {
        for (int j = i + 1; j < circlesSize; ++j) {
            long long r1 = circles[i][2];
            long long cx1 = circles[i][0];
            long long cy1 = circles[i][1];

            long long r2 = circles[j][2];
            long long cx2 = circles[j][0];
            long long cy2 = circles[j][1];

            long long dx = cx1 - cx2;
            long long dy = cy1 - cy2;

            long long dist_sq = dx * dx + dy * dy;

            long long radii_sum = r1 + r2;
            long long radii_sum_sq = radii_sum * radii_sum;

            if (dist_sq <= radii_sum_sq) {
                union_sets(i + 1, j + 1);
            }
        }
    }

    bool blocked = (find_set(0) == find_set(circlesSize + 1));

    free(parent_arr);
    parent_arr = NULL;

    return !blocked;
}