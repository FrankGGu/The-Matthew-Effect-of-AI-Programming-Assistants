#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int catMouse(int **graph, int graphSize, int *graphColSize) {
    int n = graphSize;
    int dp[n][n][2];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j][0] = dp[i][j][1] = 0;
        }
    }

    int queue[n * n * 2][3];
    int head = 0, tail = 0;

    for (int i = 1; i < n; i++) {
        dp[0][i][0] = dp[0][i][1] = 1;
        queue[tail][0] = 0;
        queue[tail][1] = i;
        queue[tail][2] = 0;
        tail++;
        queue[tail][0] = 0;
        queue[tail][1] = i;
        queue[tail][2] = 1;
        tail++;
    }

    for (int j = 1; j < n; j++) {
        dp[j][j][0] = dp[j][j][1] = 2;
        queue[tail][0] = j;
        queue[tail][1] = j;
        queue[tail][2] = 0;
        tail++;
        queue[tail][0] = j;
        queue[tail][1] = j;
        queue[tail][2] = 1;
        tail++;
    }

    while (head < tail) {
        int mouse = queue[head][0];
        int cat = queue[head][1];
        int turn = queue[head][2];
        head++;

        int result = dp[mouse][cat][turn];

        if (turn == 1) {
            for (int i = 0; i < graphColSize[cat]; i++) {
                int prevCat = graph[cat][i];
                if (prevCat == 0) continue;
                if (dp[mouse][prevCat][0] == 0) {
                    int canWin = 1;
                    for (int j = 0; j < graphColSize[prevCat]; j++) {
                        int nextMouse = graph[prevCat][j];
                        if (nextMouse == cat) continue;
                        if (dp[nextMouse][cat][1] != 2) {
                            canWin = 0;
                            break;
                        }
                    }
                    if (canWin) {
                        dp[mouse][prevCat][0] = 2;
                        queue[tail][0] = mouse;
                        queue[tail][1] = prevCat;
                        queue[tail][2] = 0;
                        tail++;
                    } else {
                        int allDraw = 1;
                        for (int j = 0; j < graphColSize[prevCat]; j++) {
                            int nextMouse = graph[prevCat][j];
                            if (nextMouse == cat) continue;
                            if (dp[nextMouse][cat][1] == 0) {
                                allDraw = 0;
                                break;
                            }
                        }
                        if (allDraw) {
                            dp[mouse][prevCat][0] = 3;
                            queue[tail][0] = mouse;
                            queue[tail][1] = prevCat;
                            queue[tail][2] = 0;
                            tail++;
                        }
                    }
                }
            }
        } else {
            for (int i = 0; i < graphColSize[mouse]; i++) {
                int prevMouse = graph[mouse][i];
                if (dp[prevMouse][cat][1] == 0) {
                    if (result == 1) {
                        dp[prevMouse][cat][1] = 1;
                        queue[tail][0] = prevMouse;
                        queue[tail][1] = cat;
                        queue[tail][2] = 1;
                        tail++;
                    } else {
                        int allDraw = 1;
                        for (int j = 0; j < graphColSize[mouse]; j++) {
                            int nextCat = graph[mouse][j];
                            if (dp[nextCat][cat][0] != 1) {
                                allDraw = 0;
                                break;
                            }
                        }
                        if (allDraw) {
                            dp[prevMouse][cat][1] = 3;
                            queue[tail][0] = prevMouse;
                            queue[tail][1] = cat;
                            queue[tail][2] = 1;
                            tail++;
                        }
                    }
                }
            }
        }
    }

    return dp[1][2][0];
}