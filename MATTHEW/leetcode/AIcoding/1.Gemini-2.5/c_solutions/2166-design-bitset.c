#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdint.h>

typedef struct {
    uint8_t* data;
    int size;
    int set_count;
    bool is_flipped;
} Bitset;

static int get_physical_bit(Bitset* obj, int idx) {
    int byte_idx = idx / 8;
    int bit_pos = idx % 8;
    return (obj->data[byte_idx] >> bit_pos) & 1;
}

static void set_physical_bit(Bitset* obj, int idx, int val) {
    int byte_idx = idx / 8;
    int bit_pos = idx % 8;
    if (val == 1) {
        obj->data[byte_idx] |= (1 << bit_pos);
    } else {
        obj->data[byte_idx] &= ~(1 << bit_pos);
    }
}

Bitset* bitsetCreate(int size) {
    Bitset* obj = (Bitset*)malloc(sizeof(Bitset));
    obj->size = size;
    obj->set_count = 0;
    obj->is_flipped = false;

    obj->data = (uint8_t*)calloc((size + 7) / 8, sizeof(uint8_t));

    return obj;
}

void bitsetFix(Bitset* obj, int idx) {
    int current_physical_val = get_physical_bit(obj, idx);
    int current_logical_val = obj->is_flipped ? (1 - current_physical_val) : current_physical_val;

    if (current_logical_val == 0) {
        int physical_val_to_set = obj->is_flipped ? 0 : 1;
        set_physical_bit(obj, idx, physical_val_to_set);
        obj->set_count++;
    }
}

void bitsetUnfix(Bitset* obj, int idx) {
    int current_physical_val = get_physical_bit(obj, idx);
    int current_logical_val = obj->is_flipped ? (1 - current_physical_val) : current_physical_val;

    if (current_logical_val == 1) {
        int physical_val_to_set = obj->is_flipped ? 1 : 0;
        set_physical_bit(obj, idx, physical_val_to_set);
        obj->set_count--;
    }
}

void bitsetFlip(Bitset* obj) {
    obj->is_flipped = !obj->is_flipped;
    obj->set_count = obj->size - obj->set_count;
}

bool bitsetAll(Bitset* obj) {
    return obj->set_count == obj->size;
}

bool bitsetOne(Bitset* obj) {
    return obj->set_count > 0;
}

int bitsetCount(Bitset* obj) {
    return obj->set_count;
}

char* bitsetToString(Bitset* obj) {
    char* str = (char*)malloc(obj->size + 1);
    for (int i = 0; i < obj->size; i++) {
        int current_physical_val = get_physical_bit(obj, i);
        int logical_val = obj->is_flipped ? (1 - current_physical_val) : current_physical_val;
        str[i] = (logical_val == 1) ? '1' : '0';
    }
    str[obj->size] = '\0';
    return str;
}

void bitsetFree(Bitset* obj) {
    free(obj->data);
    free(obj);
}