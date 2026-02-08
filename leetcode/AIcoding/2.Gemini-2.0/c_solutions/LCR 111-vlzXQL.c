#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Edge {
    int to;
    double weight;
    struct Edge* next;
};

int get_id(char* s, char** id_to_str, int* str_to_id, int* id_count) {
    if (str_to_id[s[0] - 'a' + 26 * (s[1] ? s[1] - 'a' : 0)] != -1) {
        return str_to_id[s[0] - 'a' + 26 * (s[1] ? s[1] - 'a' : 0)];
    }
    id_to_str[*id_count] = s;
    str_to_id[s[0] - 'a' + 26 * (s[1] ? s[1] - 'a' : 0)] = *id_count;
    return (*id_count)++;
}

double dfs(int start, int end, struct Edge** adj_list, int* visited, double current_weight) {
    if (start == end) {
        return current_weight;
    }
    visited[start] = 1;
    struct Edge* edge = adj_list[start];
    while (edge != NULL) {
        if (!visited[edge->to]) {
            double result = dfs(edge->to, end, adj_list, visited, current_weight * edge->weight);
            if (result != -1.0) {
                return result;
            }
        }
        edge = edge->next;
    }
    visited[start] = 0;
    return -1.0;
}

double* calcEquation(char *** equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char *** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int id_count = 0;
    char* id_to_str[20];
    int str_to_id[26 * 27];
    for (int i = 0; i < 26 * 27; i++) {
        str_to_id[i] = -1;
    }

    struct Edge* adj_list[20];
    for (int i = 0; i < 20; i++) {
        adj_list[i] = NULL;
    }

    for (int i = 0; i < equationsSize; i++) {
        int id1 = get_id(equations[i][0], id_to_str, str_to_id, &id_count);
        int id2 = get_id(equations[i][1], id_to_str, str_to_id, &id_count);

        struct Edge* edge1 = (struct Edge*)malloc(sizeof(struct Edge));
        edge1->to = id2;
        edge1->weight = values[i];
        edge1->next = adj_list[id1];
        adj_list[id1] = edge1;

        struct Edge* edge2 = (struct Edge*)malloc(sizeof(struct Edge));
        edge2->to = id1;
        edge2->weight = 1.0 / values[i];
        edge2->next = adj_list[id2];
        adj_list[id2] = edge2;
    }

    double* result = (double*)malloc(sizeof(double) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        if (str_to_id[queries[i][0][0] - 'a' + 26 * (queries[i][0][1] ? queries[i][0][1] - 'a' : 0)] == -1 || str_to_id[queries[i][1][0] - 'a' + 26 * (queries[i][1][1] ? queries[i][1][1] - 'a' : 0)] == -1) {
            result[i] = -1.0;
            continue;
        }

        int start_id = str_to_id[queries[i][0][0] - 'a' + 26 * (queries[i][0][1] ? queries[i][0][1] - 'a' : 0)];
        int end_id = str_to_id[queries[i][1][0] - 'a' + 26 * (queries[i][1][1] ? queries[i][1][1] - 'a' : 0)];

        int visited[20] = {0};
        result[i] = dfs(start_id, end_id, adj_list, visited, 1.0);
    }

    return result;
}