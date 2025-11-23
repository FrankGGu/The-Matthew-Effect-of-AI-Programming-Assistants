#include <limits.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_M 205
#define MAX_N 205
#define MAX_HEAP_SIZE (MAX_M * MAX_N)
#define MAX_TELEPORT_TYPE 1001 // Assuming teleport types are 1 to 1000

typedef struct {
    int cost;
    int r;
    int c;
} State;

State heap[MAX_HEAP_SIZE];
int heapSize;

void swap(State* a, State* b) {
    State temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(int index) {
    while (index > 0 && heap[index].cost < heap[(index - 1) / 2].cost) {
        swap(&heap[index], &heap[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

void heapifyDown(int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heapSize && heap[left].cost < heap[smallest].cost) {
        smallest = left;
    }
    if (right < heapSize && heap[right].cost < heap[smallest].cost) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap[index], &heap[smallest]);
        heapifyDown(smallest);
    }
}

void push(State s) {
    if (heapSize >= MAX_HEAP_SIZE) {
        return;
    }
    heap[heapSize++] = s;
    heapifyUp(heapSize - 1);
}

State pop() {
    if (heapSize == 0) {
        return (State){-1, -1, -1};
    }
    State root = heap[0];
    heap[0] = heap[--heapSize];
    heapifyDown(0);
    return root;
}

bool isEmpty() {
    return heapSize == 0;
}

typedef struct {
    int r, c;
} Coord;

Coord* teleportCoords[MAX_TELEPORT_TYPE];
int teleportCoordsCount[MAX_TELEPORT_TYPE];
int teleportCoordsCapacity[MAX_TELEPORT_TYPE];

void addTeleportCoord(int type, int r, int c) {
    if (type <= 0 || type >= MAX_TELEPORT_TYPE) return;

    if (teleportCoords[type] == NULL || teleportCoordsCount[type] == teleportCoordsCapacity[type]) {
        int newCapacity = (teleportCoordsCapacity[type] == 0) ? 4 : teleportCoordsCapacity[type] * 2;
        teleportCoords[type] = (Coord*)realloc(teleportCoords[type], newCapacity * sizeof(Coord));
        teleportCoordsCapacity[type] = newCapacity;
    }
    teleportCoords[type][teleportCoordsCount[type]++] = (Coord){r, c};
}

void freeTeleportCoords() {
    for (int i = 0; i < MAX_TELEPORT_TYPE; ++i) {
        if (teleportCoords[i] != NULL) {
            free(teleportCoords[i]);
            teleportCoords[i] = NULL;
        }
        teleportCoordsCount[i] = 0;
        teleportCoordsCapacity[i] = 0;
    }
}

int minCostPath(int** grid, int gridSize, int* gridColSize, int teleportCost) {
    int m = gridSize;
    int n = gridColSize[0];

    static int dist[MAX_M][MAX_N];
    static bool visitedTeleportType[MAX_TELEPORT_TYPE];

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            dist[i][j] = INT_MAX;
        }
    }
    for (int i = 0; i < MAX_TELEPORT_TYPE; ++i) {
        visitedTeleportType[i] = false;
        if (teleportCoords[i] != NULL) {
            free(teleportCoords[i]);
            teleportCoords[i] = NULL;
        }
        teleportCoordsCount[i] = 0;
        teleportCoordsCapacity[i] = 0;
    }

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            if (grid[r][c] > 0) {
                addTeleportCoord(grid[r][c], r, c);
            }
        }
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    dist[0][0] = 0;
    heapSize = 0;
    push((State){0, 0, 0});

    while (!isEmpty()) {
        State current = pop();
        int r = current.r;
        int c = current.c;
        int cost = current.cost;

        if (cost > dist[r][c]) {
            continue;
        }

        if (r == m - 1 && c == n - 1) {
            freeTeleportCoords();
            return cost;
        }

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] != -1) {
                int moveCost = 1;
                if (dist[r][c] + moveCost < dist[nr][nc]) {
                    dist[nr][nc] = dist[r][c] + moveCost;
                    push((State){dist[nr][nc], nr, nc});
                }
            }
        }

        int teleportType = grid[r][c];
        if (teleportType > 0 && !visitedTeleportType[teleportType]) {
            visitedTeleportType[teleportType] = true;

            for (int i = 0; i < teleportCoordsCount[teleportType]; ++i) {
                Coord portal = teleportCoords[teleportType][i];
                int tr = portal.r;
                int tc = portal.c;

                int newCost = dist[r][c] + teleportCost;
                if (newCost < dist[tr][tc]) {
                    dist[tr][tc] = newCost;
                    push((State){dist[tr][tc], tr, tc});
                }
            }
        }
    }

    freeTeleportCoords();
    return -1;
}

int gridTeleportationTraversal(int** grid, int gridSize, int* gridColSize, int teleportCost) {
    return minCostPath(grid, gridSize, gridColSize, teleportCost);
}