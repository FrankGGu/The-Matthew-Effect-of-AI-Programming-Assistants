#define MAX 1000

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int* graph[MAX] = {0};
    int inDegree[MAX] = {0};
    int* result = (int*)malloc(numCourses * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < MAX; i++) {
        graph[i] = (int*)malloc(MAX * sizeof(int));
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        graph[prerequisites[i][1]][inDegree[prerequisites[i][1]]++] = prerequisites[i][0];
        inDegree[prerequisites[i][0]]++;
    }

    int queue[MAX], front = 0, rear = 0;
    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int course = queue[front++];
        result[(*returnSize)++] = course;
        for (int j = 0; j < inDegree[course]; j++) {
            int nextCourse = graph[course][j];
            inDegree[nextCourse]--;
            if (inDegree[nextCourse] == 0) {
                queue[rear++] = nextCourse;
            }
        }
    }

    for (int i = 0; i < MAX; i++) {
        free(graph[i]);
    }

    if (*returnSize == numCourses) {
        return result;
    }
    free(result);
    *returnSize = 0;
    return NULL;
}