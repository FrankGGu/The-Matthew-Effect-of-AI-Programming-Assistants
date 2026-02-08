#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

int char_to_idx(char c) {
    switch (c) {
        case 'R': return 0;
        case 'Y': return 1;
        case 'B': return 2;
        case 'G': return 3;
        case 'W': return 4;
    }
    return -1;
}

char idx_to_char(int idx) {
    switch (idx) {
        case 0: return 'R';
        case 1: return 'Y';
        case 2: return 'B';
        case 3: return 'G';
        case 4: return 'W';
    }
    return '\0';
}

bool apply_removals(char* board) {
    bool changed_overall = false;

    while (true) {
        bool changed_in_iteration = false;
        int current_len = strlen(board);
        if (current_len == 0) break;

        char new_board[21];
        int new_len = 0;

        for (int i = 0; i < current_len; ) {
            char current_char = board[i];
            int j = i;
            while (j < current_len && board[j] == current_char) {
                j++;
            }
            int count = j - i;
            if (count >= 3) {
                changed_in_iteration = true;
                changed_overall = true;
            } else {
                for (int k = i; k < j; k++) {
                    new_board[new_len++] = board[k];
                }
            }
            i = j;
        }
        new_board[new_len] = '\0';

        if (!changed_in_iteration) {
            break;
        }
        strcpy(board, new_board);
    }
    return changed_overall;
}

int hand_to_key(const int hand[5]) {
    int key = 0;
    key = hand[0] * 1296 + hand[1] * 216 + hand[2] * 36 + hand[3] * 6 + hand[4];
    return key;
}

#define MAX_QUEUE_SIZE 200000

typedef struct {
    char board[21];
    int hand[5];
    int moves;
} State;

State queue[MAX_QUEUE_SIZE];
int head_q = 0, tail_q = 0;

void enqueue(const State* s) {
    queue[tail_q] = *s;
    tail_q = (tail_q + 1) % MAX_QUEUE_SIZE;
}

State dequeue() {
    State s = queue[head_q];
    head_q = (head_q + 1) % MAX_QUEUE_SIZE;
    return s;
}

bool is_queue_empty() {
    return head_q == tail_q;
}

#define HASH_TABLE_SIZE 400009

typedef struct {
    char board[21];
    int hand_key;
} VisitedKeyEntry;

VisitedKeyEntry visited_table[HASH_TABLE_SIZE];

unsigned int hash_func(const char* board_str, int hand_key) {
    unsigned int hash = 5381;
    for (int i = 0; board_str[i] != '\0'; i++) {
        hash = ((hash << 5) + hash) + board_str[i];
    }
    hash = ((hash << 5) + hash) + hand_key;
    return hash % HASH_TABLE_SIZE;
}

bool key_equals(const VisitedKeyEntry* entry, const char* board_str, int hand_key) {
    return entry->hand_key == hand_key && strcmp(entry->board, board_str) == 0;
}

bool add_visited(const char* board_str, int hand_key) {
    unsigned int h = hash_func(board_str, hand_key);
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        unsigned int idx = (h + i) % HASH_TABLE_SIZE;
        if (visited_table[idx].hand_key == -1) {
            strcpy(visited_table[idx].board, board_str);
            visited_table[idx].hand_key = hand_key;
            return true;
        }
        if (key_equals(&visited_table[idx], board_str, hand_key)) {
            return false;
        }
    }
    return false;
}

bool is_visited(const char* board_str, int hand_key) {
    unsigned int h = hash_func(board_str, hand_key);
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        unsigned int idx = (h + i) % HASH_TABLE_SIZE;
        if (visited_table[idx].hand_key == -1) {
            return false;
        }
        if (key_equals(&visited_table[idx], board_str, hand_key)) {
            return true;
        }
    }
    return false;
}

void init_visited_table() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        visited_table[i].hand_key = -1;
    }
}

int findMinStep(char* board, char* hand) {
    init_visited_table();
    head_q = 0; tail_q = 0;

    State initial_state;
    strcpy(initial_state.board, board);
    memset(initial_state.hand, 0, sizeof(initial_state.hand));
    for (int i = 0; hand[i] != '\0'; i++) {
        initial_state.hand[char_to_idx(hand[i])]++;
    }
    initial_state.moves = 0;

    apply_removals(initial_state.board);

    if (strlen(initial_state.board) == 0) {
        return 0;
    }

    enqueue(&initial_state);
    add_visited(initial_state.board, hand_to_key(initial_state.hand));

    while (!is_queue_empty()) {
        State current_state = dequeue();

        for (int i = 0; i < 5; i++) {
            if (current_state.hand[i] > 0) {
                char ball_to_insert = idx_to_char(i);

                int board_len = strlen(current_state.board);
                for (int j = 0; j <= board_len; j++) {
                    State next_state;
                    next_state.moves = current_state.moves + 1;

                    char temp_board_str[22];
                    strncpy(temp_board_str, current_state.board, j);
                    temp_board_str[j] = ball_to_insert;
                    temp_board_str[j + 1] = '\0';
                    strcat(temp_board_str, current_state.board + j);
                    strcpy(next_state.board, temp_board_str);

                    memcpy(next_state.hand, current_state.hand, sizeof(current_state.hand));
                    next_state.hand[i]--;

                    apply_removals(next_state.board);

                    if (strlen(next_state.board) == 0) {
                        return next_state.moves;
                    }

                    int next_hand_key = hand_to_key(next_state.hand);
                    if (!is_visited(next_state.board, next_hand_key)) {
                        add_visited(next_state.board, next_hand_key);
                        enqueue(&next_state);
                    }
                }
            }
        }
    }

    return -1;
}