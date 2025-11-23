#include <stdlib.h>
#include <string.h>

#define MAX_N 50001

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj_rev[MAX_N];
long long memo[MAX_N];
int* course_times;
int num_courses_global;

void add_edge(int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = u;
    newNode->next = adj_rev[v];
    adj_rev[v] = newNode;
}

long long dfs(int course_idx) {
    if (memo[course_idx] != -1) {
        return memo[course_idx];
    }

    long long max_prereq_time = 0;
    AdjNode* current = adj_rev[course_idx];
    while (current != NULL) {
        long long prereq_completion_time = dfs(current->val);
        if (prereq_completion_time > max_prereq_time) {
            max_prereq_time = prereq_completion_time;
        }
        current = current->next;
    }

    memo[course_idx] = course_times[course_idx - 1] + max_prereq_time;
    return memo[course_idx];
}

int minimumTime(int n, int* time, int timeSize, int** relations, int relationsSize, int* relationsColSize) {
    num_courses_global = n;
    course_times = time;

    for (int i = 1; i <= n; ++i) {
        adj_rev[i] = NULL;
    }

    memset(memo, -1, sizeof(long long) * (n + 1));

    for (int i = 0; i < relationsSize; ++i) {
        int u = relations[i][0];
        int v = relations[i][1];
        add_edge(u, v);
    }

    long long overall_max_time = 0;
    for (int i = 1; i <= n; ++i) {
        long long current_course_total_time = dfs(i);
        if (current_course_total_time > overall_max_time) {
            overall_max_time = current_course_total_time;
        }
    }

    for (int i = 1; i <= n; ++i) {
        AdjNode* current = adj_rev[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }

    return (int)overall_max_time;
}