#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    long long *rows;
    int row_size;
    int col_size;
} BookMyShow;

BookMyShow* bookMyShowCreate(int n, int m) {
    BookMyShow* obj = (BookMyShow*)malloc(sizeof(BookMyShow));
    obj->rows = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        obj->rows[i] = 0;
    }
    obj->row_size = n;
    obj->col_size = m;
    return obj;
}

int bookMyShowScatter(BookMyShow* obj, int k, int maxRow) {
    for (int i = 0; i <= maxRow && k > 0; i++) {
        if (obj->rows[i] < obj->col_size) {
            long long available = obj->col_size - obj->rows[i];
            if (k <= available) {
                obj->rows[i] += k;
                k = 0;
            } else {
                obj->rows[i] = obj->col_size;
                k -= available;
            }
        }
    }
    return k == 0;
}

int* bookMyShowGather(BookMyShow* obj, int k, int maxRow) {
    for (int i = 0; i <= maxRow; i++) {
        if (obj->col_size - obj->rows[i] >= k) {
            int* result = (int*)malloc(2 * sizeof(int));
            result[0] = i;
            result[1] = obj->rows[i];
            obj->rows[i] += k;
            return result;
        }
    }
    return NULL;
}

void bookMyShowFree(BookMyShow* obj) {
    free(obj->rows);
    free(obj);
}