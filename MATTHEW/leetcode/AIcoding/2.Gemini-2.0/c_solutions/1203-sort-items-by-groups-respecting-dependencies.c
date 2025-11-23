#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int val;
    struct Node* next;
} Node;

typedef struct {
    int* data;
    int size;
    int capacity;
} IntArray;

IntArray* createIntArray() {
    IntArray* arr = (IntArray*)malloc(sizeof(IntArray));
    arr->data = (int*)malloc(sizeof(int) * 1);
    arr->size = 0;
    arr->capacity = 1;
    return arr;
}

void appendIntArray(IntArray* arr, int val) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->data = (int*)realloc(arr->data, sizeof(int) * arr->capacity);
    }
    arr->data[arr->size++] = val;
}

void freeIntArray(IntArray* arr) {
    free(arr->data);
    free(arr);
}

int* sortItems(int n, int m, int* group, int groupSize, int** beforeItems, int* beforeItemsSize, int* returnSize) {
    int* itemIndegree = (int*)calloc(n, sizeof(int));
    int* groupIndegree = (int*)calloc(m, sizeof(int));
    Node** itemGraph = (Node**)malloc(n * sizeof(Node*));
    Node** groupGraph = (Node**)malloc(m * sizeof(Node*));
    for (int i = 0; i < n; i++) itemGraph[i] = NULL;
    for (int i = 0; i < m; i++) groupGraph[i] = NULL;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < beforeItemsSize[i]; j++) {
            int prevItem = beforeItems[i][j];
            Node* newNode = (Node*)malloc(sizeof(Node));
            newNode->val = i;
            newNode->next = itemGraph[prevItem];
            itemGraph[prevItem] = newNode;
            itemIndegree[i]++;

            if (group[i] != -1 && group[prevItem] != -1 && group[i] != group[prevItem]) {
                int groupId = group[i];
                int prevGroupId = group[prevItem];

                int found = 0;
                Node* curr = groupGraph[prevGroupId];
                while (curr != NULL) {
                    if (curr->val == groupId) {
                        found = 1;
                        break;
                    }
                    curr = curr->next;
                }

                if (!found) {
                    Node* newGroupNode = (Node*)malloc(sizeof(Node));
                    newGroupNode->val = groupId;
                    newGroupNode->next = groupGraph[prevGroupId];
                    groupGraph[prevGroupId] = newGroupNode;
                    groupIndegree[groupId]++;
                }
            }
        }
    }

    IntArray* sortedItems = createIntArray();
    IntArray* sortedGroups = createIntArray();
    int* groupMap = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) groupMap[i] = -1;

    int groupCount = 0;
    for (int i = 0; i < n; i++) {
        if (group[i] == -1 && itemIndegree[i] == 0) {
            appendIntArray(sortedItems, i);
            groupMap[i] = groupCount++;
        }
    }

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;
    for (int i = 0; i < n; i++) {
        if (group[i] == -1 && itemIndegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    while (head < tail) {
        int u = queue[head++];
        Node* curr = itemGraph[u];
        while (curr != NULL) {
            int v = curr->val;
            itemIndegree[v]--;
            if (itemIndegree[v] == 0) {
                if (group[v] == -1) {
                    appendIntArray(sortedItems, v);
                    queue[tail++] = v;
                    groupMap[v] = groupCount++;
                }
            }
            curr = curr->next;
        }
    }

    for (int i = 0; i < m; i++) {
        if (groupIndegree[i] == 0) {
            appendIntArray(sortedGroups, i);
        }
    }

    head = 0, tail = 0;
    int* groupQueue = (int*)malloc(m * sizeof(int));
    for(int i = 0; i < m; i++) {
        if(groupIndegree[i] == 0) {
            groupQueue[tail++] = i;
        }
    }

    while (head < tail) {
        int u = groupQueue[head++];
        Node* curr = groupGraph[u];
        while (curr != NULL) {
            int v = curr->val;
            groupIndegree[v]--;
            if (groupIndegree[v] == 0) {
                appendIntArray(sortedGroups, v);
                groupQueue[tail++] = v;
            }
            curr = curr->next;
        }
    }

    for (int i = 0; i < n; i++) {
        if (group[i] != -1 && itemIndegree[i] == 0) {
            appendIntArray(sortedItems, i);
        }
    }

    int* result = (int*)malloc(n * sizeof(int));
    int resIdx = 0;

    for (int i = 0; i < sortedGroups->size; i++) {
        int groupId = sortedGroups->data[i];

        head = 0;
        tail = 0;
        int* groupItems = (int*)malloc(n * sizeof(int));
        int* groupItemIndegree = (int*)calloc(n, sizeof(int));
        Node** groupItemGraph = (Node**)malloc(n * sizeof(Node*));
        for(int j = 0; j < n; j++) groupItemGraph[j] = NULL;

        for(int j = 0; j < n; j++) {
            if(group[j] == groupId) {
                for(int k = 0; k < beforeItemsSize[j]; k++) {
                    int prevItem = beforeItems[j][k];
                    if(group[prevItem] == groupId) {
                        Node* newNode = (Node*)malloc(sizeof(Node));
                        newNode->val = j;
                        newNode->next = groupItemGraph[prevItem];
                        groupItemGraph[prevItem] = newNode;
                        groupItemIndegree[j]++;
                    }
                }
            }
        }

        for(int j = 0; j < n; j++) {
            if(group[j] == groupId && itemIndegree[j] == 0 && groupItemIndegree[j] == 0) {
                groupItems[tail++] = j;
            }
        }

        for(int j = 0; j < n; j++) {
            if(group[j] == groupId && itemIndegree[j] == 0 && groupItemIndegree[j] == 0) {
                queue[head++] = j;
            }
        }

        while(head < tail) {
            int u = queue[head++];
            result[resIdx++] = u;
            Node* curr = groupItemGraph[u];
            while(curr != NULL) {
                int v = curr->val;
                groupItemIndegree[v]--;
                if(groupItemIndegree[v] == 0) {
                    result[resIdx++] = v;
                    queue[tail++] = v;
                }
                curr = curr->next;
            }
        }
    }

    for(int i = 0; i < sortedItems->size; i++) {
        result[resIdx++] = sortedItems->data[i];
    }

    *returnSize = res