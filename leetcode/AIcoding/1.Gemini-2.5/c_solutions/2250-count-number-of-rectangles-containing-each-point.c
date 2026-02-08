#include <stdlib.h> // For malloc, free, qsort, calloc

static int* bit;
static int bit_size;

static void ft_init(int size) {
    bit_size = size;
    // Allocate memory for BIT, +1 for 1-based indexing
    // calloc initializes memory to zero
    bit = (int*)calloc(bit_size + 1, sizeof(int));
}

static void ft_update(int idx, int val) {
    for (; idx <= bit_size; idx += idx & -idx) {
        bit[idx] += val;
    }
}

static int ft_query(int idx) {
    int sum = 0;
    for (; idx > 0; idx -= idx & -idx) {
        sum += bit[idx];
    }
    return sum;
}

typedef struct {
    int l, h;
} Rectangle;

typedef struct {
    int x, y, original_idx;
} Point;

static int compareRectangles(const void* a, const void* b) {
    Rectangle* r1 = (Rectangle*)a;
    Rectangle* r2 = (Rectangle*)b;
    // Sort by l in descending order
    return r2->l - r1->l;
}

static int comparePoints(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    // Sort by x in descending order
    return p2->x - p1->x;
}

static int compareInts(const void* a, const void* b) {
    // Sort integers in ascending order
    return *(int*)a - *(int*)b;
}

static int binary_search_lower_bound(int val, int* arr, int count) {
    int low = 0, high = count - 1, ans = count;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

static int binary_search_upper_bound(int val, int* arr, int count) {
    int low = 0, high = count - 1, ans = count;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] > val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int* countRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize, int** points, int pointsSize, int* pointsColSize, int* returnSize) {
    // 1. Prepare data structures for rectangles and points
    Rectangle* rects = (Rectangle*)malloc(rectanglesSize * sizeof(Rectangle));
    for (int i = 0; i < rectanglesSize; ++i) {
        rects[i].l = rectangles[i][0];
        rects[i].h = rectangles[i][1];
    }

    Point* pts = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; ++i) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
        pts[i].original_idx = i;
    }

    // 2. Collect all unique y-coordinates from rectangles and points for coordinate compression
    int total_y_coords = rectanglesSize + pointsSize;
    int* y_coords_all = (int*)malloc(total_y_coords * sizeof(int));
    for (int i = 0; i < rectanglesSize; ++i) {
        y_coords_all[i] = rects[i].h;
    }
    for (int i = 0; i < pointsSize; ++i) {
        y_coords_all[rectanglesSize + i] = pts[i].y;
    }

    // Sort all y-coordinates
    qsort(y_coords_all, total_y_coords, sizeof(int), compareInts);

    // Remove duplicates to get unique sorted y-coordinates
    int y_coords_unique_count = 0;
    if (total_y_coords > 0) {
        y_coords_unique_count = 1; // First element is always unique
        for (int i = 1; i < total_y_coords; ++i) {
            if (y_coords_all[i] != y_coords_all[i-1]) {
                y_coords_all[y_coords_unique_count++] = y_coords_all[i];
            }
        }
    }
    // y_coords_all now contains unique sorted y-coordinates up to y_coords_unique_count

    // 3. Initialize Fenwick Tree with the size of unique y-coordinates
    ft_init(y_coords_unique_count);

    // 4. Sort rectangles and points based on x-coordinates (l for rects, x for points) in descending order
    qsort(rects, rectanglesSize, sizeof(Rectangle), compareRectangles);
    qsort(pts, pointsSize, sizeof(Point), comparePoints);

    // 5. Process points
    int* ans = (int*)malloc(pointsSize * sizeof(int));
    *returnSize = pointsSize;

    int rect_ptr = 0; // Pointer for iterating through sorted rectangles
    for (int i = 0; i < pointsSize; ++i) {
        Point current_point = pts[i];

        // Add rectangles whose 'l' is >= current_point.x to the Fenwick Tree
        // These rectangles satisfy the l <= px condition for current_point and subsequent points
        while (rect_ptr < rectanglesSize && rects[rect_ptr].l >= current_point.x) {
            // Get 1-based compressed index for rectangle's height 'h'
            int h_compressed_idx = binary_search_lower_bound(rects[rect_ptr].h, y_coords_all, y_coords_unique_count) + 1;
            ft_update(h_compressed_idx, 1); // Add 1 to count for this height
            rect_ptr++;
        }

        // Query Fenwick Tree for rectangles whose 'h' is <= current_point.y
        // Get the 1-based compressed index for point's y-coordinate 'py'
        // This index represents the count of unique y-coordinates <= current_point.y
        int py_compressed_idx = binary_search_upper_bound(current_point.y, y_coords_all, y_coords_unique_count);
        ans[current_point.original_idx] = ft_query(py_compressed_idx);
    }

    // 6. Clean up allocated memory
    free(rects);
    free(pts);
    free(y_coords_all);
    free(bit); // Free the BIT memory

    return ans; // Return the result array
}