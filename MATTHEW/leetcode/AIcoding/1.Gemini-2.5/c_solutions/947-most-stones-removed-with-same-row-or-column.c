#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

static int* parent_coords;
static int* sz_coords;

static int find_coords(int i) {
    if (parent_coords[i] == i)
        return i;
    return parent_coords[i] = find_coords(parent_coords[i]);
}

static void unite_coords(int i, int j) {
    int root_i = find_coords(i);
    int root_j = find_coords(j);
    if (root_i != root_j) {
        if (sz_coords[root_i] < sz_coords[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        parent_coords[root_j] = root_i;
        sz_coords[root_i] += sz_coords[root_j];
    }
}

int removeStones(int** stones, int stonesSize, int* stonesColSize) {
    if (stonesSize <= 1) {
        return 0;
    }

    const int MAX_COORD_VAL = 10000;
    // DSU_SIZE covers indices for rows (0 to MAX_COORD_VAL) and
    // columns (MAX_COORD_VAL + 1 to 2 * MAX_COORD_VAL + 1).
    // Total size needed: (2 * MAX_COORD_VAL + 1) + 1 = 2 * MAX_COORD_VAL + 2.
    const int DSU_SIZE = 2 * MAX_COORD_VAL + 2; 

    parent_coords = (int*)malloc(DSU_SIZE * sizeof(int));
    sz_coords = (int*)malloc(DSU_SIZE * sizeof(int));

    for (int i = 0; i < DSU_SIZE; ++i) {
        parent_coords[i] = i;
        sz_coords[i] = 1;
    }

    // isActive tracks which coordinate indices (rows or mapped columns) have been encountered.
    // This helps in correctly counting the number of connected components among the active coordinates.
    bool* isActive = (bool*)calloc(DSU_SIZE, sizeof(bool)); 

    int num_components = 0;

    for (int i = 0; i < stonesSize; ++i) {
        int r = stones[i][0];
        int c = stones[i][1];
        // Map column 'c' to a distinct index range to avoid collision with row indices.
        // For example, if rows are 0..10000, columns can be 10001..20001.
        int col_mapped_idx = c + MAX_COORD_VAL + 1;

        // If 'r' is a new coordinate, it initially forms a new component.
        if (!isActive[r]) {
            isActive[r] = true;
            num_components++;
        }
        // If 'col_mapped_idx' is a new coordinate, it initially forms a new component.
        if (!isActive[col_mapped_idx]) {
            isActive[col_mapped_idx] = true;
            num_components++;
        }

        // Union the row and column coordinates for the current stone.
        // If they were in different components, the total number of components decreases by one.
        int root_r = find_coords(r);
        int root_c = find_coords(col_mapped_idx);

        if (root_r != root_c) {
            unite_coords(r, col_mapped_idx);
            num_components--;
        }
    }

    free(parent_coords);
    free(sz_coords);
    free(isActive);

    // The maximum number of stones that can be removed is (total stones) - (number of connected components).
    // 'num_components' now holds the count of distinct connected components formed by the stones.
    return stonesSize - num_components;
}