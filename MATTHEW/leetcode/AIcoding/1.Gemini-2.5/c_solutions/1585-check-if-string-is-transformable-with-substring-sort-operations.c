#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

void IntVector_init(IntVector* vec, int initial_capacity) {
    vec->data = (int*)malloc(sizeof(int) * initial_capacity);
    vec->size = 0;
    vec->capacity = initial_capacity;
}

void IntVector_push_back(IntVector* vec, int value) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2;
        if (vec->capacity == 0) vec->capacity = 1; // Handle initial capacity 0 case, though we start with 1+
        vec->data = (int*)realloc(vec->data, sizeof(int) * vec->capacity);
    }
    vec->data[vec->size++] = value;
}

void IntVector_free(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

bool isTransformable(char * s, char * t){
    int n = strlen(s);

    int counts[10] = {0};
    for (int i = 0; i < n; i++) {
        counts[s[i] - '0']++;
        counts[t[i] - '0']--;
    }
    for (int i = 0; i < 10; i++) {
        if (counts[i] != 0) {
            return false;
        }
    }

    IntVector pos[10];
    for (int i = 0; i < 10; i++) {
        IntVector_init(&pos[i], n / 10 + 1); 
    }

    for (int i = 0; i < n; i++) {
        IntVector_push_back(&pos[s[i] - '0'], i);
    }

    int s_ptr[10] = {0}; 

    for (int i = 0; i < n; i++) {
        int target_char_val = t[i] - '0';

        int s_original_idx = pos[target_char_val].data[s_ptr[target_char_val]];

        for (int d_val = 0; d_val < 10; d_val++) {
            if (s_ptr[d_val] < pos[d_val].size) {
                int current_s_char_idx = pos[d_val].data[s_ptr[d_val]];

                if (d_val < target_char_val && current_s_char_idx < s_original_idx) {
                    for (int j = 0; j < 10; j++) {
                        IntVector_free(&pos[j]);
                    }
                    return false;
                }

                if (d_val > target_char_val && current_s_char_idx < i) {
                    for (int j = 0; j < 10; j++) {
                        IntVector_free(&pos[j]);
                    }
                    return false;
                }
            }
        }
        s_ptr[target_char_val]++;
    }

    for (int i = 0; i < 10; i++) {
        IntVector_free(&pos[i]);
    }

    return true;
}