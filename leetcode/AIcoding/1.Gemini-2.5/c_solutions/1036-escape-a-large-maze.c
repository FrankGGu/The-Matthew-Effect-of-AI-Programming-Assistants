#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset

#define GRID_SIZE 1000000
#define MAX_BLOCKED 200
#define SAFE_THRESHOLD (MAX_BLOCKED * MAX_BLOCKED) // 40000

#define VISITED_HASH_CAPACITY (SAFE_THRESHOLD * 2) // 80000
long long visited_hash_table[VISITED_HASH_CAPACITY];

#define BLOCKED_HASH_CAPACITY (MAX_BLOCKED * 2) // 400
long long blocked_hash_table[BLOCKED_HASH_CAPACITY];

typedef struct {
    int x;
    int y;
} Point;

Point queue[SAFE_THRESHOLD + 1];
int head, tail;

long long point_to_key(int x, int y) {
    return (long long)x * GRID_SIZE + y + 1; // Add 1 to ensure key is never 0
}

void init_hash_table(long long* table, int capacity) {
    memset(table, 0, sizeof(long long) * capacity);
}

bool hash_table_contains(long long* table, int capacity, long long key) {
    int idx = (int)(key % capacity);
    while (table[idx] != 0LL) {
        if (table[idx] == key) {
            return true;
        }
        idx = (idx + 1) % capacity;
    }
    return false;
}

void hash_table_add(long long* table, int capacity, long long key) {
    int idx = (int)(key % capacity);
    while (table[idx] != 0LL) {
        if (table[idx] == key) { // Already exists
            return;
        }
        idx = (idx + 1) % capacity;
    }
    table[idx] = key;
}

bool bfs(int startX, int startY, int targetX, int targetY) {
    init_hash_table(visited_hash_table, VISITED_HASH_CAPACITY);
    int visited_count = 0;

    head = 0;
    tail = 0;

    long long start_key = point_to_key(startX, startY);
    hash_table_add(visited_hash_table, VISITED_HASH_CAPACITY, start_key);
    visited_count++;
    queue[tail++] = (Point){startX, startY};

    int dr[] = {-1, 1, 0, 0}; // Directions: Up, Down, Left, Right
    int dc[] = {0, 0, -1, 1};

    while (head != tail) {
        Point curr = queue[head++];
        if (head == SAFE_THRESHOLD + 1) head = 0; // Circular queue wrap-around

        if (curr.x == targetX && curr.y == targetY) {
            return true; // Target reached
        }

        if (visited_count > SAFE_THRESHOLD) {
            return true; // Explored enough cells to be considered "escaped"
        }

        for (int i = 0; i < 4; ++i) {
            int nx = curr.x + dr[i];
            int ny = curr.y + dc[i];

            // Check grid boundaries
            if (nx >= 0 && nx < GRID_SIZE && ny >= 0 && ny < GRID_SIZE) {
                long long next_key = point_to_key(nx, ny);
                // Check if not blocked and not visited
                if (!hash_table_contains(blocked_hash_table, BLOCKED_HASH_CAPACITY, next_key) &&
                    !hash_table_contains(visited_hash_table, VISITED_HASH_CAPACITY, next_key)) {

                    hash_table_add(visited_hash_table, VISITED_HASH_CAPACITY, next_key);
                    visited_count++;
                    queue[tail++] = (Point){nx, ny};
                    if (tail == SAFE_THRESHOLD + 1) tail = 0; // Circular queue wrap-around
                }
            }
        }
    }
    return false; // Could not reach target and did not escape the blocked region
}

bool isEscapePossible(int** blocked_cells, int blockedSize, int* blockedColSize, int* source, int* target) {
    // If there are no blocked cells, it's always possible to escape.
    if (blockedSize == 0) {
        return true;
    }

    // Initialize blocked hash table from input
    init_hash_table(blocked_hash_table, BLOCKED_HASH_CAPACITY);
    for (int i = 0; i < blockedSize; ++i) {
        long long key = point_to_key(blocked_cells[i][0], blocked_cells[i][1]);
        hash_table_add(blocked_hash_table, BLOCKED_HASH_CAPACITY, key);
    }

    // Perform BFS from source to target.
    // If source can reach target, OR source can escape the region enclosed by blocked cells,
    // then we need to check if target can also escape.
    if (bfs(source[0], source[1], target[0], target[1])) {
        // Now, perform BFS from target to source.
        // If target can reach source, OR target can escape the region enclosed by blocked cells,
        // then a path exists.
        return bfs(target[0], target[1], source[0], source[1]);
    }

    return false; // Source could not reach target and could not escape the blocked region.
}