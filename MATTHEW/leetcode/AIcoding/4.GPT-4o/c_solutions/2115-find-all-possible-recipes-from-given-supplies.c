#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Graph {
    int numCourses;
    int *indegree;
    char ***adjList;
    char **recipes;
};

struct Queue {
    char **items;
    int front, rear, capacity;
};

struct Queue* createQueue(int capacity) {
    struct Queue* queue = (struct Queue*)malloc(sizeof(struct Queue));
    queue->capacity = capacity;
    queue->front = queue->rear = -1;
    queue->items = (char**)malloc(capacity * sizeof(char*));
    return queue;
}

int isFull(struct Queue* queue) {
    return queue->rear == queue->capacity - 1;
}

int isEmpty(struct Queue* queue) {
    return queue->front == -1;
}

void enqueue(struct Queue* queue, char* item) {
    if (!isFull(queue)) {
        if (isEmpty(queue)) queue->front = 0;
        queue->items[++queue->rear] = item;
    }
}

char* dequeue(struct Queue* queue) {
    if (!isEmpty(queue)) {
        char* item = queue->items[queue->front];
        if (queue->front == queue->rear) queue->front = queue->rear = -1;
        else queue->front++;
        return item;
    }
    return NULL;
}

int* findAllRecipes(char ** recipes, int recipesSize, char ** ingredients, int ingredientsSize, char ** supplies, int suppliesSize, int* returnSize) {
    struct Graph graph;
    graph.numCourses = recipesSize;
    graph.indegree = (int*)calloc(recipesSize, sizeof(int));
    graph.adjList = (char***)malloc(recipesSize * sizeof(char**));

    for (int i = 0; i < recipesSize; i++) {
        graph.adjList[i] = (char**)malloc(ingredientsSize * sizeof(char*));
    }

    for (int i = 0; i < recipesSize; i++) {
        int count = 0;
        for (int j = 0; j < ingredientsSize; j++) {
            if (strcmp(recipes[i], ingredients[j]) != 0) {
                graph.adjList[i][count++] = ingredients[j];
            } else {
                graph.indegree[i]++;
            }
        }
        graph.adjList[i][count] = NULL;
    }

    struct Queue* queue = createQueue(recipesSize);
    for (int i = 0; i < suppliesSize; i++) {
        for (int j = 0; j < recipesSize; j++) {
            if (strcmp(supplies[i], recipes[j]) == 0) {
                enqueue(queue, recipes[j]);
            }
        }
    }

    char** result = (char**)malloc(recipesSize * sizeof(char*));
    int index = 0;

    while (!isEmpty(queue)) {
        char* recipe = dequeue(queue);
        result[index++] = recipe;

        for (int i = 0; i < recipesSize; i++) {
            if (strcmp(recipe, recipes[i]) == 0) {
                for (char **ing = graph.adjList[i]; *ing; ing++) {
                    int found = 0;
                    for (int j = 0; j < suppliesSize; j++) {
                        if (strcmp(*ing, supplies[j]) == 0) {
                            found = 1;
                            break;
                        }
                    }
                    if (found) {
                        graph.indegree[i]--;
                        if (graph.indegree[i] == 0) {
                            enqueue(queue, recipes[i]);
                        }
                    }
                }
                break;
            }
        }
    }

    free(graph.indegree);
    free(graph.adjList);
    free(queue->items);
    free(queue);

    *returnSize = index;
    return result;
}