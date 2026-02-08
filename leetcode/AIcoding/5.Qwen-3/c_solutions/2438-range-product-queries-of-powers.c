#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* prefix;
    int size;
} RangeProductQueries;

RangeProductQueries* rangeProductQueriesCreate(char* nums) {
    int n = strlen(nums);
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 1;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] * (nums[i] - '0');
    }
    RangeProductQueries* obj = (RangeProductQueries*)malloc(sizeof(RangeProductQueries));
    obj->prefix = prefix;
    obj->size = n;
    return obj;
}

int rangeProductQueriesQuery(RangeProductQueries* obj, int left, int right) {
    int result = 1;
    for (int i = left; i <= right; i++) {
        result *= obj->prefix[i + 1] / obj->prefix[i];
    }
    return result;
}

void rangeProductQueriesFree(RangeProductQueries* obj) {
    free(obj->prefix);
    free(obj);
}