#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    double value;
    int used;
} Node;

int backtrack(Node* nodes, int n, double target) {
    if (n == 1) {
        return fabs(nodes[0].value - target) < 1e-6;
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j) {
                Node new_nodes[4];
                int k = 0;
                for (int m = 0; m < n; m++) {
                    if (m != i && m != j) {
                        new_nodes[k++] = nodes[m];
                    }
                }
                double a = nodes[i].value;
                double b = nodes[j].value;
                new_nodes[k].value = a + b;
                new_nodes[k].used = 1;
                if (backtrack(new_nodes, n - 1, target)) return 1;
                new_nodes[k].value = a - b;
                if (backtrack(new_nodes, n - 1, target)) return 1;
                new_nodes[k].value = b - a;
                if (backtrack(new_nodes, n - 1, target)) return 1;
                new_nodes[k].value = a * b;
                if (backtrack(new_nodes, n - 1, target)) return 1;
                if (b != 0) {
                    new_nodes[k].value = a / b;
                    if (backtrack(new_nodes, n - 1, target)) return 1;
                }
                if (a != 0) {
                    new_nodes[k].value = b / a;
                    if (backtrack(new_nodes, n - 1, target)) return 1;
                }
            }
        }
    }
    return 0;
}

bool judgePoint24(int* nums, int numsSize) {
    Node nodes[4];
    for (int i = 0; i < 4; i++) {
        nodes[i].value = nums[i];
        nodes[i].used = 0;
    }
    return backtrack(nodes, 4, 24);
}