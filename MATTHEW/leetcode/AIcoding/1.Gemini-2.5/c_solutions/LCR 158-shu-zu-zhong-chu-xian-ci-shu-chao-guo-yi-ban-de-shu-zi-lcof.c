#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct {
    int height;
    int r;
    int c;
} Cell;

Cell* heap_arr;
int heap_capacity_val;
int heap_size_val;

void swap_cells(Cell* a, Cell* b) {
    Cell temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up_func(int index) {
    while (index > 0) {
        int parent_index = (index - 1) / 2;
        if (heap_arr[index].height < heap_arr[parent_index].height) {
            swap_cells(&heap_arr[index], &heap_arr[parent_index]);
            index = parent_index;
        } else {
            break;
        }
    }
}

void heapify_down_func(int index) {
    while (1) {
        int left_child = 2 * index + 1;
        int right_child = 2 * index + 2;
        int smallest = index;

        if (left_child < heap_size_val && heap_arr[left_child].height < heap_arr[smallest].height) {
            smallest = left_child;
        }
        if (right_child < heap_size_val && heap_arr[right_child].height < heap_arr[smallest].height) {
            smallest = right_child;
        }

        if (smallest != index) {
            swap_cells(&heap_arr[index], &heap_arr[smallest]);
            index = smallest;
        } else {
            break;
        }
    }
}

void heap_push_func(Cell cell) {
    heap_arr[heap_size_val++] = cell;
    heapify_up_func(heap_size_val - 1);
}

Cell heap_pop_func() {
    Cell root = heap_arr[0];
    heap_arr[0] = heap_arr[--heap_size_val];
    heapify_down_func(0);
    return root;
}

bool heap_is_empty_func() {
    return heap_size_val == 0;
}

int trapRainWater(int** heightMap, int heightMapSize, int* heightMapColSize) {
    if (heightMapSize == 0 || *heightMapColSize == 0) {
        return 0;
    }

    int m = heightMapSize;
    int n = *heightMapColSize;

    heap_capacity_val = m * n;
    heap_arr = (Cell*)malloc(sizeof(Cell) * heap_capacity_val);
    heap_size_val = 0;

    bool** visited = (bool**)malloc(sizeof(bool*) * m);
    for (int i = 0; i < m; ++i) {
        visited[i] = (bool*)malloc(sizeof(bool) * n);
        memset(visited[i], 0, sizeof(bool) * n);
    }

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            if (r == 0 || r == m - 1 || c == 0 || c == n - 1) {
                heap_push_func((Cell){heightMap[r][c], r, c});
                visited[r][c] = true;
            }
        }
    }

    int total_water = 0;
    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (!heap_is_empty_func()) {
        Cell current = heap_pop_func();
        int h = current.height;
        int r = current.r;
        int c = current.c;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                visited[nr][nc] = true;
                total_water += (h > heightMap[nr][nc] ? h - heightMap[nr][nc] : 0);
                heap_push_func((Cell){(h > heightMap[nr][nc] ? h : heightMap[nr][nc]), nr, nc});
            }
        }
    }

    free(heap_arr);
    for (int i = 0; i < m; ++i) {
        free(visited[i]);
    }
    free(visited);

    return total_water;
}