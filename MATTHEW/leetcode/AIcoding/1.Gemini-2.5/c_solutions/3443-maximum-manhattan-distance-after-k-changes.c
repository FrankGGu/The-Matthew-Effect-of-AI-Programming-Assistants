#include <stdlib.h> // For abs, max, min
#include <limits.h> // For LLONG_MAX, LLONG_MIN

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

static long long get_max_u_excluding_val(int excluded_idx, int u_max1_idx, long long u_max1_val, long long u_max2_val) {
    return (excluded_idx == u_max1_idx) ? u_max2_val : u_max1_val;
}

static long long get_min_u_excluding_val(int excluded_idx, int u_min1_idx, long long u_min1_val, long long u_min2_val) {
    return (excluded_idx == u_min1_idx) ? u_min2_val : u_min1_val;
}

static long long get_max_v_excluding_val(int excluded_idx, int v_max1_idx, long long v_max1_val, long long v_max2_val) {
    return (excluded_idx == v_max1_idx) ? v_max2_val : v_max1_val;
}

static long long get_min_v_excluding_val(int excluded_idx, int v_min1_idx, long long v_min1_val, long long v_min2_val) {
    return (excluded_idx == v_min1_idx) ? v_min2_val : v_min1_val;
}

long long maxManhattanDistanceAfterKChanges(int** points, int pointsSize, int* pointsColSize, int k) {
    if (pointsSize == 0) {
        return 0;
    }
    // If N=1, the distance between any two points is 0 (since there's only one point).
    // If K=1 and N=1, we change the only point, distance remains 0.
    if (pointsSize == 1) {
        return 0;
    }

    // Maximum possible coordinate value is 10^9.
    // So, max possible sum/difference (x+y or x-y) is 2 * 10^9.
    long long const C = 2000000000LL; 

    // If K >= 2, we can change two points to achieve the maximum possible Manhattan distance.
    // Set point A to (C, C) and point B to (-C, -C).
    // Distance = |C - (-C)| + |C - (-C)| = 2C + 2C = 4C.
    if (k >= 2) {
        return 4LL * C; 
    }

    // Variables to store the largest, second largest, smallest, and second smallest
    // values of (x+y) and (x-y), along with their original indices.
    // Initialize with LLONG_MIN/MAX for robustness.
    long long u_max1_val = LLONG_MIN; 
    long long u_max2_val = LLONG_MIN;
    int u_max1_idx = -1;
    int u_max2_idx = -1;

    long long u_min1_val = LLONG_MAX;
    long long u_min2_val = LLONG_MAX;
    int u_min1_idx = -1;
    int u_min2_idx = -1;

    long long v_max1_val = LLONG_MIN;
    long long v_max2_val = LLONG_MIN;
    int v_max1_idx = -1;
    int v_max2_idx = -1;

    long long v_min1_val = LLONG_MAX;
    long long v_min2_val = LLONG_MAX;
    int v_min1_idx = -1;
    int v_min2_idx = -1;

    // Iterate through all points to find the extreme u and v values
    for (int i = 0; i < pointsSize; ++i) {
        long long cur_x = points[i][0];
        long long cur_y = points[i][1];
        long long cur_u = cur_x + cur_y;
        long long cur_v = cur_x - cur_y;

        // Update u (x+y) extremes
        if (cur_u >= u_max1_val) {
            if (u_max1_idx != i) { // If current point is different from previous max point
                u_max2_val = u_max1_val;
                u_max2_idx = u_max1_idx;
            }
            u_max1_val = cur_u;
            u_max1_idx = i;
        } else if (cur_u > u_max2_val) {
            u_max2_val = cur_u;
            u_max2_idx = i;
        }

        if (cur_u <= u_min1_val) {
            if (u_min1_idx != i) { // If current point is different from previous min point
                u_min2_val = u_min1_val;
                u_min2_idx = u_min1_idx;
            }
            u_min1_val = cur_u;
            u_min1_idx = i;
        } else if (cur_u < u_min2_val) {
            u_min2_val = cur_u;
            u_min2_idx = i;
        }

        // Update v (x-y) extremes
        if (cur_v >= v_max1_val) {
            if (v_max1_idx != i) {
                v_max2_val = v_max1_val;
                v_max2_idx = v_max1_idx;
            }
            v_max1_val = cur_v;
            v_max1_idx = i;
        } else if (cur_v > v_max2_val) {
            v_max2_val = cur_v;
            v_max2_idx = i;
        }

        if (cur_v <= v_min1_val) {
            if (v_min1_idx != i) {
                v_min2_val = v_min1_val;
                v_min2_idx = v_min1_idx;
            }
            v_min1_val = cur_v;
            v_min1_idx = i;
        } else if (cur_v < v_min2_val) {
            v_min2_val = cur_v;
            v_min2_idx = i;
        }
    }

    long long ans = 0;

    if (k == 0) {
        // No changes, calculate initial max Manhattan distance
        // max(|x1-x2| + |y1-y2|) = max(max(x+y)-min(x+y), max(x-y)-min(x-y))
        ans = MAX(u_max1_val - u_min1_val, v_max1_val - v_min1_val);
    } else { // k == 1
        // With one change, we can modify one point (x_k, y_k) to (x_k', y_k').
        // This changes u_k = x_k+y_k to u_k' and v_k = x_k-y_k to v_k'.
        // We can choose (x_k', y_k') to make u_k' or v_k' extreme, but not both simultaneously.
        // For example:
        // 1. To make u_k' = C (max possible): set (x_k', y_k') = (C/2, C/2) or (C, 0). Then v_k' = 0.
        // 2. To make u_k' = -C (min possible): set (x_k', y_k') = (-C/2, -C/2) or (-C, 0). Then v_k' = 0.
        // 3. To make v_k' = C (max possible): set (x_k', y_k') = (C/2, -C/2) or (C, 0). Then u_k' = 0.
        // 4. To make v_k' = -C (min possible): set (x_k', y_k') = (-C/2, C/2) or (-C, 0). Then u_k' = 0.
        // We consider 4 scenarios by picking one point to change and making one of its u/v values extreme.

        // Scenario 1: Change point u_min1_idx. Set its new u-value to C (max). Its new v-value becomes 0.
        // The new u-range will be C - (second smallest u-value).
        // The new v-range will be max(v_values_excluding_changed_point, 0) - min(v_values_excluding_changed_point, 0).
        long long current_u_range = C - get_min_u_excluding_val(u_min1_idx, u_min1_idx, u_min1_val, u_min2_val);
        long long current_v_max = get_max_v_excluding_val(u_min1_idx, v_max1_idx, v_max1_val, v_max2_val);
        long long current_v_min = get_min_v_excluding_val(u_min1_idx, v_min1_idx, v_min1_val, v_min2_val);
        current_v_max = MAX(current_v_max, 0LL); // The changed point's v-value is 0, so it might become new max/min
        current_v_min = MIN(current_v_min, 0LL);
        long long current_v_range = current_v_max - current_v_min;
        ans = MAX(ans, MAX(current_u_range, current_v_range));

        // Scenario 2: Change point u_max1_idx. Set its new u-value to -C (min). Its new v-value becomes 0.
        // The new u-range will be (second largest u-value) - (-C).
        current_u_range = get_max_u_excluding_val(u_max1_idx, u_max1_idx, u_max1_val, u_max2_val) - (-C);
        current_v_max = get_max_v_excluding_val(u_max1_idx, v_max1_idx, v_max1_val, v_max2_val);
        current_v_min = get_min_v_excluding_val(u_max1_idx, v_min1_idx, v_min1_val, v_min2_val);
        current_v_max = MAX(current_v_max, 0LL);
        current_v_min = MIN(current_v_min, 0LL);
        current_v_range = current_v_max - current_v_min;
        ans = MAX(ans, MAX(current_u_range, current_v_range));

        // Scenario 3: Change point v_min1_idx. Set its new v-value to C (max). Its new u-value becomes 0.
        // The new v-range will be C - (second smallest v-value).
        current_v_range = C - get_min_v_excluding_val(v_min1_idx, v_min1_idx, v_min1_val, v_min2_val);
        long long current_u_max = get_max_u_excluding_val(v_min1_idx, u_max1_idx, u_max1_val, u_max2_val);
        long long current_u_min = get_min_u_excluding_val(v_min1_idx, u_min1_idx, u_min1_val, u_min2_val);
        current_u_max = MAX(current_u_max, 0LL);
        current_u_min = MIN(current_u_min, 0LL);
        current_u_range = current_u_max - current_u_min;
        ans = MAX(ans, MAX(current_u_range, current_v_range));

        // Scenario 4: Change point v_max1_idx. Set its new v-value to -C (min). Its new u-value becomes 0.
        // The new v-range will be (second largest v-value) - (-C).
        current_v_range = get_max_v_excluding_val(v_max1_idx, v_max1_idx, v_max1_val, v_max2_val) - (-C);
        current_u_max = get_max_u_excluding_val(v_max1_idx, u_max1_idx, u_max1_val, u_max2_val);
        current_u_min = get_min_u_excluding_val(v_max1_idx, u_min1_idx, u_min1_val, u_min2_val);
        current_u_max = MAX(current_u_max, 0LL);
        current_u_min = MIN(current_u_min, 0LL);
        current_u_range = current_u_max - current_u_min;
        ans = MAX(ans, MAX(current_u_range, current_v_range));
    }

    return ans;
}