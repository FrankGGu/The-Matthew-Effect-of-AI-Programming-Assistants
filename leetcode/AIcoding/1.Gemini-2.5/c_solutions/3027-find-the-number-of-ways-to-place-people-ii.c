#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int x;
    int y;
    int y_compressed; // Stores the compressed y-coordinate
} Point;

int comparePoints(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }
    return p2->y - p1->y;
}

int compareInts(const void* a, const void* b) {
    return *(const int*)a - *(const int*)b;
}

#define SEG_TREE_MAX_VAL -1 // Initialize with a value smaller than any possible y

int* tree;
int tree_nodes_count; // Total number of nodes in the segment tree

void build_segment_tree(int node_idx, int start, int end) {
    if (start == end) {
        tree[node_idx] = SEG_TREE_MAX_VAL;
    } else {
        int mid = start + (end - start) / 2;
        build_segment_tree(2 * node_idx, start, mid);
        build_segment_tree(2 * node_idx + 1, mid + 1, end);
        tree[node_idx] = SEG_TREE_MAX_VAL; // Parent node also initialized
    }
}

void update_segment_tree(int node_idx, int start, int end, int target_idx, int val) {
    if (start == end) { // Leaf node
        tree[node_idx] = val;
    } else {
        int mid = start + (end - start) / 2;
        if (target_idx <= mid) { // Go to left child
            update_segment_tree(2 * node_idx, start, mid, target_idx, val);
        } else { // Go to right child
            update_segment_tree(2 * node_idx + 1, mid + 1, end, target_idx, val);
        }
        // Update parent node with the maximum of its children
        tree[node_idx] = (tree[2 * node_idx] > tree[2 * node_idx + 1]) ? tree[2 * node_idx] : tree[2 * node_idx + 1];
    }
}

int query_segment_tree_max(int node_idx, int start, int end, int l, int r) {
    // If query range is outside node range or invalid
    if (r < start || end < l || l > r) {
        return SEG_TREE_MAX_VAL;
    }
    // If node range is completely within query range
    if (l <= start && end <= r) {
        return tree[node_idx];
    }
    // Partial overlap, recurse
    int mid = start + (end - start) / 2;
    int p1 = query_segment_tree_max(2 * node_idx, start, mid, l, r);
    int p2 = query_segment_tree_max(2 * node_idx + 1, mid + 1, end, l, r);
    return (p1 > p2) ? p1 : p2;
}

int find_y_compressed_idx(int y_val, int* y_coords_map, int y_coords_count) {
    int low = 0;
    int high = y_coords_count - 1;
    int ans = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (y_coords_map[mid] == y_val) {
            ans = mid;
            break;
        } else if (y_coords_map[mid] < y_val) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}

int numberOfWays(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize <= 1) {
        return pointsSize; // A single point can't form a pair, but the problem implies distinct points.
                           // If problem means pairs (p1, p2) where p1 != p2, then 0 for pointsSize <= 1.
                           // However, based on examples, it's counting "maximal points".
                           // If pointsSize=0, ans=0. If pointsSize=1, ans=1 (it's maximal).
                           // The problem examples imply that a point can see itself if it's not blocked.
                           // For example, [[1,1],[2,2],[3,3]] -> 3. Each point is maximal.
                           // So if pointsSize = 1, it implies 1 way.
                           // Let's return pointsSize for <= 1, as per maximal points interpretation.
    }

    Point* p_arr = (Point*)malloc(pointsSize * sizeof(Point));
    int* all_y_coords = (int*)malloc(pointsSize * sizeof(int));

    for (int i = 0; i < pointsSize; i++) {
        p_arr[i].x = points[i][0];
        p_arr[i].y = points[i][1];
        all_y_coords[i] = points[i][1];
    }

    // Coordinate compression for y-values
    qsort(all_y_coords, pointsSize, sizeof(int), compareInts);

    int y_coords_count = 0;
    if (pointsSize > 0) {
        all_y_coords[y_coords_count++] = all_y_coords[0];
        for (int i = 1; i < pointsSize; i++) {
            if (all_y_coords[i] != all_y_coords[i - 1]) {
                all_y_coords[y_coords_count++] = all_y_coords[i];
            }
        }
    }

    for (int i = 0; i < pointsSize; i++) {
        p_arr[i].y_compressed = find_y_compressed_idx(p_arr[i].y, all_y_coords, y_coords_count);
    }

    // Sort points: x ascending, then y descending for equal x
    qsort(p_arr, pointsSize, sizeof(Point), comparePoints);

    // Initialize segment tree
    tree_nodes_count = 4 * y_coords_count; // Max size for segment tree
    tree = (int*)malloc(tree_nodes_count * sizeof(int));
    build_segment_tree(1, 0, y_coords_count - 1);

    int ans = 0;
    int i = 0;
    while (i < pointsSize) {
        int j = i;
        // Group points with the same x-coordinate
        while (j < pointsSize && p_arr[j].x == p_arr[i].x) {
            j++;
        }

        // For each point P[k] in this group (i <= k < j):
        // P[k] is a potential p1. Check if it's a maximal point.
        // A point P[k] is maximal if no point P[m] with x_m < P[k].x and y_m >= P[k].y exists.
        // Query segment tree for max_y_val in range [P[k].y_compressed, M-1].
        // This range corresponds to y-values >= P[k].y.
        // If the max_y_val found in this range (from points with x < P[k].x) is less than P[k].y,
        // it means no point to the left and above P[k] exists.
        // So P[k] is a maximal point.
        for (int k = i; k < j; k++) {
            int max_y_found = query_segment_tree_max(1, 0, y_coords_count - 1, p_arr[k].y_compressed, y_coords_count - 1);
            if (max_y_found < p_arr[k].y) {
                ans++;
            }
        }

        // After processing all points in the current x-group, add them to the segment tree.
        // Update the segment tree with their y-values.
        for (int k = i; k < j; k++) {
            update_segment_tree(1, 0, y_coords_count - 1, p_arr[k].y_compressed, p_arr[k].y);
        }

        i = j;
    }

    free(p_arr);
    free(all_y_coords);
    free(tree);

    return ans;
}