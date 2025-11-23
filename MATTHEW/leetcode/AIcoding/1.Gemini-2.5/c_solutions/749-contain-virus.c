#include <stdlib.h>
#include <string.h> // For memset

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

typedef struct {
    int r, c;
} Cell;

Cell queue[50 * 50];
int head, tail;

void enqueue(int r, int c) {
    queue[tail].r = r;
    queue[tail].c = c;
    tail++;
}

Cell dequeue() {
    return queue[head++];
}

int is_empty() {
    return head == tail;
}

typedef struct {
    int wallsNeeded;
    int willInfectCount;
    Cell infectedCells[50 * 50]; // Stores the actual infected cells of this region
    int infectedCount;
} RegionInfo;

int M, N;

int is_valid(int r, int c) {
    return r >= 0 && r < M && c >= 0 && c < N;
}

int containVirus(int** grid, int gridSize, int* gridColSize) {
    M = gridSize;
    N = gridColSize[0];

    int totalWalls = 0;

    while (1) {
        RegionInfo regions[M * N]; // Max possible regions
        int numRegions = 0;
        int maxInfections = -1;
        int bestRegionIdx = -1;

        // visitedGlobal: marks infected cells that have been processed as part of a region in this iteration
        int visitedGlobal[M][N];
        memset(visitedGlobal, 0, sizeof(visitedGlobal)); // 0: not visited, 1: visited

        // visitedWillInfectTemp: marks healthy cells that would be infected by the CURRENT region being processed
        // This is reset for each BFS.
        int visitedWillInfectTemp[M][N];

        for (int r = 0; r < M; ++r) {
            for (int c = 0; c < N; ++c) {
                if (grid[r][c] == 1 && !visitedGlobal[r][c]) { // Found a new unvisited infected cell
                    head = 0;
                    tail = 0;

                    memset(visitedWillInfectTemp, 0, sizeof(visitedWillInfectTemp)); // Reset for new region BFS

                    RegionInfo currentRegion;
                    currentRegion.wallsNeeded = 0;
                    currentRegion.willInfectCount = 0;
                    currentRegion.infectedCount = 0;

                    enqueue(r, c);
                    visitedGlobal[r][c] = 1; // Mark as visited for this iteration
                    currentRegion.infectedCells[currentRegion.infectedCount++] = (Cell){r, c};

                    while (!is_empty()) {
                        Cell curr = dequeue();

                        for (int i = 0; i < 4; ++i) {
                            int nr = curr.r + dr[i];
                            int nc = curr.c + dc[i];

                            if (is_valid(nr, nc)) {
                                if (grid[nr][nc] == 1 && !visitedGlobal[nr][nc]) {
                                    // Another infected cell in the same region
                                    enqueue(nr, nc);
                                    visitedGlobal[nr][nc] = 1;
                                    currentRegion.infectedCells[currentRegion.infectedCount++] = (Cell){nr, nc};
                                } else if (grid[nr][nc] == 0) {
                                    // Healthy cell that would be infected
                                    if (!visitedWillInfectTemp[nr][nc]) {
                                        currentRegion.willInfectCount++;
                                        currentRegion.wallsNeeded++; // A wall is needed for each unique healthy neighbor
                                        visitedWillInfectTemp[nr][nc] = 1;
                                    }
                                }
                            }
                        }
                    }

                    // Only consider regions that can actually infect healthy cells
                    if (currentRegion.willInfectCount > 0) {
                        regions[numRegions] = currentRegion;
                        if (currentRegion.willInfectCount > maxInfections) {
                            maxInfections = currentRegion.willInfectCount;
                            bestRegionIdx = numRegions;
                        }
                        numRegions++;
                    }
                }
            }
        }

        if (bestRegionIdx == -1) { // No active regions found that can spread
            break;
        }

        totalWalls += regions[bestRegionIdx].wallsNeeded;

        // Contain the best region: mark its infected cells as 'contained' (e.g., 2)
        for (int i = 0; i < regions[bestRegionIdx].infectedCount; ++i) {
            Cell c = regions[bestRegionIdx].infectedCells[i];
            grid[c.r][c.c] = 2; // Mark as contained
        }

        // Spread the virus in all other active regions (synchronously)
        Cell cellsToInfect[M * N];
        int cellsToInfectCount = 0;
        // willBeInfected: marks healthy cells that are targeted for infection in this spreading phase
        int willBeInfected[M][N]; 
        memset(willBeInfected, 0, sizeof(willBeInfected));

        for (int r_spread = 0; r_spread < M; ++r_spread) {
            for (int c_spread = 0; c_spread < N; ++c_spread) {
                if (grid[r_spread][c_spread] == 1) { // This is an active infected cell (not contained)
                    for (int i = 0; i < 4; ++i) {
                        int nr = r_spread + dr[i];
                        int nc = c_spread + dc[i];

                        if (is_valid(nr, nc) && grid[nr][nc] == 0 && !willBeInfected[nr][nc]) {
                            cellsToInfect[cellsToInfectCount++] = (Cell){nr, nc};
                            willBeInfected[nr][nc] = 1;
                        }
                    }
                }
            }
        }

        // Apply the infections
        for (int i = 0; i < cellsToInfectCount; ++i) {
            Cell cell = cellsToInfect[i];
            grid[cell.r][cell.c] = 1;
        }
    }

    return totalWalls;
}