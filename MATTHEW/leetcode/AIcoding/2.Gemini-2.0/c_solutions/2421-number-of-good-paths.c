#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int parent;
    int max_val;
} UnionFind;

UnionFind* createUnionFind(int n, int* vals) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind) * n);
    for (int i = 0; i < n; i++) {
        uf[i].parent = i;
        uf[i].max_val = vals[i];
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf, uf[x].parent);
    }
    return uf[x].parent;
}

void unite(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf[rootX].max_val >= uf[rootY].max_val) {
            uf[rootY].parent = rootX;
        } else {
            uf[rootX].parent = rootY;
        }
    }
}

int numberOfGoodPaths(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize) {
    UnionFind* uf = createUnionFind(valsSize, vals);
    int goodPaths = valsSize;

    typedef struct {
        int u;
        int v;
        int max_val;
    } EdgeInfo;

    EdgeInfo* edge_infos = (EdgeInfo*)malloc(sizeof(EdgeInfo) * edgesSize);
    for (int i = 0; i < edgesSize; i++) {
        edge_infos[i].u = edges[i][0];
        edge_infos[i].v = edges[i][1];
        edge_infos[i].max_val = (vals[edges[i][0]] > vals[edges[i][1]]) ? vals[edges[i][0]] : vals[edges[i][1]];
    }

    for (int i = 0; i < edgesSize; i++) {
        for (int j = i + 1; j < edgesSize; j++) {
            if (edge_infos[i].max_val > edge_infos[j].max_val) {
                EdgeInfo temp = edge_infos[i];
                edge_infos[i] = edge_infos[j];
                edge_infos[j] = temp;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edge_infos[i].u;
        int v = edge_infos[i].v;

        if (vals[u] <= vals[v])
        {
            if (vals[find(uf, u)] == vals[v])
            {
                int rootU = find(uf, u);
                int rootV = find(uf, v);
                if (rootU != rootV)
                {
                    int countU = 0, countV = 0;
                    for (int k = 0; k < valsSize; k++)
                    {
                        if (find(uf, k) == rootU && vals[k] == vals[v])
                        {
                            countU++;
                        }
                        if (find(uf, k) == rootV && vals[k] == vals[v])
                        {
                            countV++;
                        }
                    }
                    goodPaths += countU * countV;
                    unite(uf, u, v);
                }
            }
        }
        else
        {
            if (vals[find(uf, v)] == vals[u])
            {
                int rootU = find(uf, u);
                int rootV = find(uf, v);
                if (rootU != rootV)
                {
                    int countU = 0, countV = 0;
                    for (int k = 0; k < valsSize; k++)
                    {
                        if (find(uf, k) == rootU && vals[k] == vals[u])
                        {
                            countU++;
                        }
                        if (find(uf, k) == rootV && vals[k] == vals[u])
                        {
                            countV++;
                        }
                    }
                    goodPaths += countU * countV;
                    unite(uf, u, v);
                }
            }
        }

        if (vals[u] == vals[v])
        {
            int rootU = find(uf, u);
            int rootV = find(uf, v);
            if (rootU != rootV)
            {
                int countU = 0, countV = 0;
                for (int k = 0; k < valsSize; k++)
                {
                    if (find(uf, k) == rootU && vals[k] == vals[u])
                    {
                        countU++;
                    }
                    if (find(uf, k) == rootV && vals[k] == vals[u])
                    {
                        countV++;
                    }
                }
                goodPaths += countU * countV;
                unite(uf, u, v);
            }
        }
    }

    free(uf);
    free(edge_infos);
    return goodPaths;
}