#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int val;
    struct Node* next;
} Node;

Node* createNode(int val) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = NULL;
    return newNode;
}

void addEdge(Node** graph, int from, int to) {
    Node* newNode = createNode(to);
    newNode->next = graph[from];
    graph[from] = newNode;
}

int* topoSort(Node** graph, int n, int* inDegree, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;
    int* queue = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    *returnSize = 0;
    while (front < rear) {
        int node = queue[front++];
        result[(*returnSize)++] = node;

        Node* temp = graph[node];
        while (temp != NULL) {
            inDegree[temp->val]--;
            if (inDegree[temp->val] == 0) {
                queue[rear++] = temp->val;
            }
            temp = temp->next;
        }
    }

    free(queue);
    return result;
}

int* sortItems(int n, int m, int* group, int groupSize, int** beforeItems, int beforeItemsSize, int* beforeItemsColSize, int* returnSize) {
    int groupId = m;
    for (int i = 0; i < n; i++) {
        if (group[i] == -1) {
            group[i] = groupId++;
        }
    }

    int totalGroups = groupId;
    Node** itemGraph = (Node**)malloc(n * sizeof(Node*));
    int* itemInDegree = (int*)calloc(n, sizeof(int));

    Node** groupGraph = (Node**)malloc(totalGroups * sizeof(Node*));
    int* groupInDegree = (int*)calloc(totalGroups, sizeof(int));

    for (int i = 0; i < n; i++) {
        itemGraph[i] = NULL;
    }
    for (int i = 0; i < totalGroups; i++) {
        groupGraph[i] = NULL;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < beforeItemsColSize[i]; j++) {
            int prev = beforeItems[i][j];
            addEdge(itemGraph, prev, i);
            itemInDegree[i]++;

            if (group[prev] != group[i]) {
                addEdge(groupGraph, group[prev], group[i]);
                groupInDegree[group[i]]++;
            }
        }
    }

    int groupOrderSize;
    int* groupOrder = topoSort(groupGraph, totalGroups, groupInDegree, &groupOrderSize);

    int itemOrderSize;
    int* itemOrder = topoSort(itemGraph, n, itemInDegree, &itemOrderSize);

    if (itemOrderSize != n || groupOrderSize != totalGroups) {
        *returnSize = 0;
        free(groupOrder);
        free(itemOrder);
        free(itemGraph);
        free(groupGraph);
        free(itemInDegree);
        free(groupInDegree);
        return NULL;
    }

    Node** groupToItems = (Node**)malloc(totalGroups * sizeof(Node*));
    for (int i = 0; i < totalGroups; i++) {
        groupToItems[i] = NULL;
    }

    for (int i = 0; i < n; i++) {
        int g = group[itemOrder[i]];
        Node* newNode = createNode(itemOrder[i]);
        newNode->next = groupToItems[g];
        groupToItems[g] = newNode;
    }

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < totalGroups; i++) {
        int g = groupOrder[i];
        Node* temp = groupToItems[g];
        while (temp != NULL) {
            result[(*returnSize)++] = temp->val;
            temp = temp->next;
        }
    }

    for (int i = 0; i < n; i++) {
        Node* temp = itemGraph[i];
        while (temp != NULL) {
            Node* toFree = temp;
            temp = temp->next;
            free(toFree);
        }
    }
    for (int i = 0; i < totalGroups; i++) {
        Node* temp = groupGraph[i];
        while (temp != NULL) {
            Node* toFree = temp;
            temp = temp->next;
            free(toFree);
        }
    }
    for (int i = 0; i < totalGroups; i++) {
        Node* temp = groupToItems[i];
        while (temp != NULL) {
            Node* toFree = temp;
            temp = temp->next;
            free(toFree);
        }
    }

    free(itemGraph);
    free(groupGraph);
    free(groupToItems);
    free(itemInDegree);
    free(groupInDegree);
    free(groupOrder);
    free(itemOrder);

    return result;
}