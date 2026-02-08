#include <string.h>

int parent[10];

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        parent[root_i] = root_j;
    }
}

int minOperations(char * num1, char * num2) {
    for (int i = 0; i < 10; ++i) {
        parent[i] = i;
    }

    int len = strlen(num1);

    for (int i = 0; i < len; ++i) {
        int d1 = num1[i] - '0';
        int d2 = num2[i] - '0';
        if (d1 != d2) {
            unite(d1, d2);
        }
    }

    int num_components = 0;
    for (int i = 0; i < 10; ++i) {
        if (parent[i] == i) {
            num_components++;
        }
    }

    return 10 - num_components;
}