#include <stdlib.h>
#include <limits.h>

typedef struct {
    long long val;
    int id;
} PointCoord;

int comparePointCoord(const void* a, const void* b) {
    long long val_a = ((PointCoord*)a)->val;
    long long val_b = ((PointCoord*)b)->val;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int minimizeManhattanDistance(int** points, int pointsSize, int* pointsColSize) {
    int n = pointsSize;

    PointCoord* u_coords = (PointCoord*)malloc(n * sizeof(PointCoord));
    PointCoord* v_coords = (PointCoord*)malloc(n * sizeof(PointCoord));

    for (int i = 0; i < n; ++i) {
        long long x = points[i][0];
        long long y = points[i][1];
        u_coords[i].val = x + y;
        u_coords[i].id = i;
        v_coords[i].val = x - y;
        v_coords[i].id = i;
    }

    qsort(u_coords, n, sizeof(PointCoord), comparePointCoord);
    qsort(v_coords, n, sizeof(PointCoord), comparePointCoord);

    long long min_overall_max_dist = LLONG_MAX;

    for (int k = 0; k < n; ++k) {
        long long current_min_u, current_max_u;

        // Determine min_u for points excluding p_k
        if (u_coords[0].id == k) {
            current_min_u = u_coords[1].val;
        } else {
            current_min_u = u_coords[0].val;
        }

        // Determine max_u for points excluding p_k
        if (u_coords[n - 1].id == k) {
            current_max_u = u_coords[n - 2].val;
        } else {
            current_max_u = u_coords[n - 1].val;
        }

        long long current_min_v, current_max_v;

        // Determine min_v for points excluding p_k
        if (v_coords[0].id == k) {
            current_min_v = v_coords[1].val;
        } else {
            current_min_v = v_coords[0].val;
        }

        // Determine max_v for points excluding p_k
        if (v_coords[n - 1].id == k) {
            current_max_v = v_coords[n - 2].val;
        } else {
            current_max_v = v_coords[n - 1].val;
        }

        long long current_max_dist = max(current_max_u - current_min_u, current_max_v - current_min_v);
        min_overall_max_dist = min(min_overall_max_dist, current_max_dist);
    }

    free(u_coords);
    free(v_coords);

    return (int)min_overall_max_dist;
}