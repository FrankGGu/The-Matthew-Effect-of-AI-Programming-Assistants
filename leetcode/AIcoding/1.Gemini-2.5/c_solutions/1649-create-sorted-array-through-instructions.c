#include <stdlib.h>
#include <string.h>

#define MAX_VAL 100000
#define MOD 1000000007

int bit[MAX_VAL + 1];

void update(int idx, int delta) {
    for (; idx <= MAX_VAL; idx += idx & (-idx)) {
        bit[idx] += delta;
    }
}

int query(int idx) {
    int sum = 0;
    for (; idx > 0; idx -= idx & (-idx)) {
        sum += bit[idx];
    }
    return sum;
}

int createSortedArray(int* instructions, int instructionsSize) {
    memset(bit, 0, sizeof(bit)); 

    long long total_cost = 0;

    for (int i = 0; i < instructionsSize; ++i) {
        int val = instructions[i];

        int less_count = query(val - 1);
        int greater_count = i - query(val);

        int current_cost = (less_count < greater_count) ? less_count : greater_count;
        total_cost = (total_cost + current_cost) % MOD;

        update(val, 1);
    }

    return (int)total_cost;
}