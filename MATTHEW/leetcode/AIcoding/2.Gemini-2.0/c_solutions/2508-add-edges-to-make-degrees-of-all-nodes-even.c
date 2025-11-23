#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canMakeEven(int n, int** edges, int edgesSize, int* edgesColSize) {
    int degree[n + 1];
    for (int i = 1; i <= n; i++) {
        degree[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    int oddDegreeCount = 0;
    int oddDegrees[4];
    int oddDegreeIndex = 0;

    for (int i = 1; i <= n; i++) {
        if (degree[i] % 2 != 0) {
            oddDegreeCount++;
            oddDegrees[oddDegreeIndex++] = i;
        }
    }

    if (oddDegreeCount == 0) {
        return true;
    } else if (oddDegreeCount == 2) {
        int u = oddDegrees[0];
        int v = oddDegrees[1];
        for (int i = 1; i <= n; i++) {
            bool edgeExists = false;
            if (i == u || i == v) continue;
            for (int j = 0; j < edgesSize; j++) {
                if ((edges[j][0] == u && edges[j][1] == v) || (edges[j][0] == v && edges[j][1] == u) ||
                    (edges[j][0] == u && edges[j][1] == i) || (edges[j][0] == i && edges[j][1] == u) ||
                    (edges[j][0] == v && edges[j][1] == i) || (edges[j][0] == i && edges[j][1] == v)) {
                    edgeExists = true;
                    break;
                }
            }
            if (!edgeExists) return true;
        }
        return false;
    } else if (oddDegreeCount == 4) {
        int a = oddDegrees[0];
        int b = oddDegrees[1];
        int c = oddDegrees[2];
        int d = oddDegrees[3];

        bool ab_cd = true;
        for (int i = 0; i < edgesSize; i++) {
            if ((edges[i][0] == a && edges[i][1] == b) || (edges[i][0] == b && edges[i][1] == a)) ab_cd = false;
        }
        if (ab_cd) {
            ab_cd = true;
            for (int i = 0; i < edgesSize; i++) {
                if ((edges[i][0] == c && edges[i][1] == d) || (edges[i][0] == d && edges[i][1] == c)) ab_cd = false;
            }
            if (ab_cd) return true;
        }

        bool ac_bd = true;
        for (int i = 0; i < edgesSize; i++) {
            if ((edges[i][0] == a && edges[i][1] == c) || (edges[i][0] == c && edges[i][1] == a)) ac_bd = false;
        }
        if (ac_bd) {
            ac_bd = true;
            for (int i = 0; i < edgesSize; i++) {
                if ((edges[i][0] == b && edges[i][1] == d) || (edges[i][0] == d && edges[i][1] == b)) ac_bd = false;
            }
            if (ac_bd) return true;
        }

        bool ad_bc = true;
        for (int i = 0; i < edgesSize; i++) {
            if ((edges[i][0] == a && edges[i][1] == d) || (edges[i][0] == d && edges[i][1] == a)) ad_bc = false;
        }
        if (ad_bc) {
            ad_bc = true;
            for (int i = 0; i < edgesSize; i++) {
                if ((edges[i][0] == b && edges[i][1] == c) || (edges[i][0] == c && edges[i][1] == b)) ad_bc = false;
            }
            if (ad_bc) return true;
        }

        return false;
    } else {
        return false;
    }
}