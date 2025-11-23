#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_QUEUE_SIZE 720 // Max number of unique states for a 2x3 board is 6! = 720.
#define HASH_TABLE_SIZE 1009 // A prime number for hash table size

typedef struct QueueNode {
    char board[7];
    int zero_pos;
    int moves;
} QueueNode;

typedef struct HashEntry {
    char board[7];
    struct HashEntry* next;
} HashEntry;

HashEntry* hashTable[HASH_TABLE_SIZE];

unsigned int hash(const char* s) {
    unsigned int h = 0;
    for (int i = 0; i < 6; i++) {
        h = (h << 5) - h + s[i];
    }
    return h % HASH_TABLE_SIZE;
}

bool contains(const char* s) {
    unsigned int idx = hash(s);
    HashEntry* entry = hashTable[idx];
    while (entry != NULL) {
        if (strcmp(entry->board, s) == 0) {
            return true;
        }
        entry = entry->next;
    }
    return false;
}

void add(const char* s) {
    unsigned int idx = hash(s);
    HashEntry* newEntry = (HashEntry*)malloc(sizeof(HashEntry));
    strcpy(newEntry->board, s);
    newEntry->next = hashTable[idx];
    hashTable[idx] = newEntry;
}

void freeHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        HashEntry* entry = hashTable[i];
        while (entry != NULL) {
            HashEntry* temp = entry;
            entry = entry->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

int adj_indices[6][4] = {
    {1, 3, -1, -1},
    {0, 2, 4, -1},
    {1, 5, -1, -1},
    {0, 4, -1, -1},
    {1, 3, 5, -1},
    {2, 4, -1, -1}
};

int slidingPuzzle(int** board, int boardSize, int* boardColSize) {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hashTable[i] = NULL;
    }

    QueueNode queue[MAX_QUEUE_SIZE];
    int head = 0;
    int tail = 0;

    char initial_board_str[7];
    int zero_pos = -1;

    for (int r = 0; r < 2; r++) {
        for (int c = 0; c < 3; c++) {
            initial_board_str[r * 3 + c] = board[r][c] + '0';
            if (board[r][c] == 0) {
                zero_pos = r * 3 + c;
            }
        }
    }
    initial_board_str[6] = '\0';

    if (strcmp(initial_board_str, "123450") == 0) {
        freeHashTable();
        return 0;
    }

    strcpy(queue[tail].board, initial_board_str);
    queue[tail].zero_pos = zero_pos;
    queue[tail].moves = 0;
    tail++;

    add(initial_board_str);

    while (head < tail) {
        QueueNode current = queue[head++];

        for (int i = 0; adj_indices[current.zero_pos][i] != -1; i++) {
            int next_zero_pos = adj_indices[current.zero_pos][i];

            char next_board_str[7];
            strcpy(next_board_str, current.board);

            char temp = next_board_str[current.zero_pos];
            next_board_str[current.zero_pos] = next_board_str[next_zero_pos];
            next_board_str[next_zero_pos] = temp;

            if (!contains(next_board_str)) {
                if (strcmp(next_board_str, "123450") == 0) {
                    freeHashTable();
                    return current.moves + 1;
                }

                add(next_board_str);
                strcpy(queue[tail].board, next_board_str);
                queue[tail].zero_pos = next_zero_pos;
                queue[tail].moves = current.moves + 1;
                tail++;
            }
        }
    }

    freeHashTable();
    return -1;
}