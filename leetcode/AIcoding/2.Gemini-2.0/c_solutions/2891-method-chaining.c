#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
} Num;

Num* init(int val) {
    Num* num = (Num*)malloc(sizeof(Num));
    num->val = val;
    return num;
}

Num* add(Num* num, int val) {
    num->val += val;
    return num;
}

Num* multiply(Num* num, int val) {
    num->val *= val;
    return num;
}

int get_value(Num* num) {
    return num->val;
}

void free_num(Num* num) {
    free(num);
}