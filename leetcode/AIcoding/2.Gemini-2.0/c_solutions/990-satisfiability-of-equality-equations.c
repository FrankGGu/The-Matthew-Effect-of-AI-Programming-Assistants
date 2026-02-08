#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);

    if (xroot != yroot) {
        if (rank[xroot] < rank[yroot])
            parent[xroot] = yroot;
        else if (rank[xroot] > rank[yroot])
            parent[yroot] = xroot;
        else {
            parent[yroot] = xroot;
            rank[xroot]++;
        }
    }
}

bool equationsPossible(char ** equations, int equationsSize){
    int parent[26];
    int rank[26];

    for (int i = 0; i < 26; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '=') {
            unite(parent, rank, equations[i][0] - 'a', equations[i][3] - 'a');
        }
    }

    for (int i = 0; i < equationsSize; i++) {
        if (equations[i][1] == '!') {
            if (find(parent, equations[i][0] - 'a') == find(parent, equations[i][3] - 'a'))
                return false;
        }
    }

    return true;
}