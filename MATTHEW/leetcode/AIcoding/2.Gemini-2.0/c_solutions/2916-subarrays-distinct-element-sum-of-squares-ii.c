#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct Node {
    long long val;
    long long cnt;
} Node;

int cmp(const void *a, const void *b) {
    return ((Node *)a)->val - ((Node *)b)->val;
}