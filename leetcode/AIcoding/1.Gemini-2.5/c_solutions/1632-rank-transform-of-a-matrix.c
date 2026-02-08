#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memset

#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

typedef struct {
    int val;
    int r;
    int c;
} Element;

int compareElements(const void *a, const void *b) {
    return ((Element *)a)->val - ((Element *)b)->val;
}

static int *parent_dsu;
static int *component_max_prev_rank_for_roots_dsu;

int find_set(int i) {
    if (parent_dsu[i] == i)
        return i;
    return parent_dsu[i] = find_set(parent_dsu[i]);
}

void union_sets(int a, int b) {
    int rootA = find_set(a);
    int rootB = find_set(b);
    if (rootA != rootB) {
        parent_dsu[rootB] = rootA;
        component_max_prev_rank_for_roots_dsu[rootA] = MAX(component_max_prev_rank_for_roots_dsu[rootA], component_max_prev_rank_for_roots_dsu[rootB]);
    }
}

typedef struct {
    int r;
    int c;
    int rank;
} Update;

int** matrixRankTransform(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int m = matrixSize;
    int n = matrixColSize[0];

    int** rank_matrix = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        rank_matrix[i] = (int*)malloc(n * sizeof(int));
    }
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int* row_max_rank = (int*)calloc(m, sizeof(int));
    int* col_max_rank = (int*)calloc(n, sizeof(int));

    int num_elements = m * n;
    Element* elements = (Element*)malloc(num_elements * sizeof(Element));
    int k = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            elements[k].val = matrix[i][j];
            elements[k].r = i;
            elements[k].c = j;
            k++;
        }
    }

    qsort(elements, num_elements, sizeof(Element), compareElements);

    parent_dsu = (int*)malloc((m + n) * sizeof(int));
    component_max_prev_rank_for_roots_dsu = (int*)malloc((m + n) * sizeof(int));

    Update* updates = (Update*)malloc(num_elements * sizeof(Update));
    int num_updates_in_group;

    int* modified_dsu_indices = (int*)malloc((m + n) * sizeof(int));
    int modified_count = 0;
    char* is_dsu_element_initialized_for_group = (char*)calloc(m + n, sizeof(char));

    int curr_idx = 0;
    while (curr_idx < num_elements) {
        int start_idx = curr_idx;
        int current_val = elements[curr_idx].val;

        while (curr_idx < num_elements && elements[curr_idx].val == current_val) {
            curr_idx++;
        }

        modified_count = 0;
        for (int i = start_idx; i < curr_idx; i++) {
            int r = elements[i].r;
            int c = elements[i].c;

            if (!is_dsu_element_initialized_for_group[r]) {
                parent_dsu[r] = r;
                component_max_prev_rank_for_roots_dsu[r] = 0;
                is_dsu_element_initialized_for_group[r] = 1;
                modified_dsu_indices[modified_count++] = r;
            }
            if (!is_dsu_element_initialized_for_group[m + c]) {
                parent_dsu[m + c] = m + c;
                component_max_prev_rank_for_roots_dsu[m + c] = 0;
                is_dsu_element_initialized_for_group[m + c] = 1;
                modified_dsu_indices[modified_count++] = m + c;
            }
        }

        for (int i = start_idx; i < curr_idx; i++) {
            int r = elements[i].r;
            int c = elements[i].c;

            int root_r = find_set(r);
            int root_c = find_set(m + c);

            component_max_prev_rank_for_roots_dsu[root_r] = MAX(component_max_prev_rank_for_roots_dsu[root_r], row_max_rank[r]);
            component_max_prev_rank_for_roots_dsu[root_c] = MAX(component_max_prev_rank_for_roots_dsu[root_c], col_max_rank[c]);

            union_sets(r, m + c);
        }

        num_updates_in_group = 0;
        for (int i = start_idx; i < curr_idx; i++) {
            int r = elements[i].r;
            int c = elements[i].c;

            int root = find_set(r);
            int new_rank = 1 + component_max_prev_rank_for_roots_dsu[root];
            rank_matrix[r][c] = new_rank;

            updates[num_updates_in_group].r = r;
            updates[num_updates_in_group].c = c;
            updates[num_updates_in_group].rank = new_rank;
            num_updates_in_group++;
        }

        for (int i = 0; i < num_updates_in_group; i++) {
            row_max_rank[updates[i].r] = MAX(row_max_rank[updates[i].r], updates[i].rank);
            col_max_rank[updates[i].c] = MAX(col_max_rank[updates[i].c], updates[i].rank);
        }

        for (int i = 0; i < modified_count; i++) {
            is_dsu_element_initialized_for_group[modified_dsu_indices[i]] = 0;
        }
    }

    free(row_max_rank);
    free(col_max_rank);
    free(elements);
    free(parent_dsu);
    free(component_max_prev_rank_for_roots_dsu);
    free(updates);
    free(modified_dsu_indices);
    free(is_dsu_element_initialized_for_group);

    return rank_matrix;
}