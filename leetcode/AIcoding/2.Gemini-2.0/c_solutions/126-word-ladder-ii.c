#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 16
#define MAX_WORD_COUNT 5000

typedef struct Node {
    char word[MAX_WORD_LEN];
    int level;
    int prev_count;
    int prev_indices[MAX_WORD_COUNT];
} Node;

int word_distance(const char *word1, const char *word2) {
    int diff = 0;
    for (int i = 0; word1[i] != '\0' && word2[i] != '\0'; ++i) {
        if (word1[i] != word2[i]) {
            diff++;
        }
    }
    return diff;
}

char*** findLadders(char* beginWord, char* endWord, char** wordList, int wordListSize, int* returnSize, int** returnColumnSizes) {
    int begin_index = -1;
    int end_index = -1;
    for (int i = 0; i < wordListSize; ++i) {
        if (strcmp(wordList[i], endWord) == 0) {
            end_index = i;
        }
    }

    if (end_index == -1) {
        *returnSize = 0;
        return NULL;
    }

    int begin_exists = 0;
    for (int i = 0; i < wordListSize; ++i) {
        if (strcmp(wordList[i], beginWord) == 0) {
            begin_exists = 1;
            break;
        }
    }

    int total_words = wordListSize + (begin_exists ? 0 : 1);
    Node* nodes = (Node*)malloc(sizeof(Node) * total_words);

    int begin_node_index = begin_exists ? -1 : 0;

    if (!begin_exists) {
        strcpy(nodes[0].word, beginWord);
        nodes[0].level = -1;
        nodes[0].prev_count = 0;

    }

    for (int i = 0; i < wordListSize; ++i) {
        strcpy(nodes[begin_exists ? i : i + 1].word, wordList[i]);
        nodes[begin_exists ? i : i + 1].level = -1;
        nodes[begin_exists ? i : i + 1].prev_count = 0;

        if (strcmp(wordList[i], beginWord) == 0) {
            begin_node_index = begin_exists ? i : i + 1;
        }
    }

    nodes[begin_node_index].level = 0;
    int queue[total_words];
    int queue_head = 0;
    int queue_tail = 0;
    queue[queue_tail++] = begin_node_index;

    int end_node_index = begin_exists ? end_index : end_index + 1;
    int min_level = -1;

    while (queue_head < queue_tail) {
        int current_index = queue[queue_head++];
        if (min_level != -1 && nodes[current_index].level > min_level) {
            break;
        }

        for (int i = 0; i < total_words; ++i) {
            if (i == current_index) continue;
            if (word_distance(nodes[current_index].word, nodes[i].word) == 1) {
                if (nodes[i].level == -1) {
                    nodes[i].level = nodes[current_index].level + 1;
                    nodes[i].prev_indices[nodes[i].prev_count++] = current_index;
                    queue[queue_tail++] = i;

                    if (i == end_node_index) {
                        min_level = nodes[i].level;
                    }

                } else if (nodes[i].level == nodes[current_index].level + 1) {
                    nodes[i].prev_indices[nodes[i].prev_count++] = current_index;
                }
            }
        }
    }

    if (nodes[end_node_index].level == -1) {
        *returnSize = 0;
        free(nodes);
        return NULL;
    }

    int** paths = (int**)malloc(sizeof(int*) * 10000);
    int* path = (int*)malloc(sizeof(int) * (nodes[end_node_index].level + 1));
    int path_count = 0;

    void find_paths(int current_index, int level) {
        path[level] = current_index;
        if (level == 0) {
            paths[path_count] = (int*)malloc(sizeof(int) * (nodes[end_node_index].level + 1));
            memcpy(paths[path_count], path, sizeof(int) * (nodes[end_node_index].level + 1));
            path_count++;
            return;
        }

        for (int i = 0; i < nodes[current_index].prev_count; ++i) {
            find_paths(nodes[current_index].prev_indices[i], level - 1);
        }
    }

    find_paths(end_node_index, nodes[end_node_index].level);

    char*** result = (char***)malloc(sizeof(char**) * path_count);
    *returnColumnSizes = (int*)malloc(sizeof(int) * path_count);
    *returnSize = path_count;

    for (int i = 0; i < path_count; ++i) {
        result[i] = (char**)malloc(sizeof(char*) * (nodes[end_node_index].level + 1));
        (*returnColumnSizes)[i] = nodes[end_node_index].level + 1;
        for (int j = 0; j <= nodes[end_node_index].level; ++j) {
            result[i][j] = (char*)malloc(sizeof(char) * MAX_WORD_LEN);
            strcpy(result[i][j], nodes[paths[i][nodes[end_node_index].level - j]].word);
        }
    }

    for (int i = 0; i < path_count; ++i) {
        free(paths[i]);
    }
    free(paths);
    free(path);
    free(nodes);

    return result;
}