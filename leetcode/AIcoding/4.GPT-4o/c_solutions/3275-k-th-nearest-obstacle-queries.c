#define MAXN 100000

typedef struct {
    int x, y;
} Point;

int cmp(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int manhattan(Point a, Point b) {
    return abs(a.x - b.x) + abs(a.y - b.y);
}

int* kNearest(int** obstacles, int obstaclesSize, int* obstaclesColSize, int** queries, int queriesSize, int* k, int* returnSize) {
    Point obs[MAXN], q[MAXN], res[MAXN];
    int i, j, dist;
    *returnSize = queriesSize;
    int *answers = (int *)malloc(queriesSize * sizeof(int));

    for (i = 0; i < obstaclesSize; i++) {
        obs[i].x = obstacles[i][0];
        obs[i].y = obstacles[i][1];
    }
    qsort(obs, obstaclesSize, sizeof(Point), cmp);

    for (i = 0; i < queriesSize; i++) {
        q[i].x = queries[i][0];
        q[i].y = queries[i][1];

        int count = 0;
        for (j = 0; j < obstaclesSize; j++) {
            dist = manhattan(q[i], obs[j]);
            if (count < k[i]) {
                answers[i] = dist;
                count++;
            } else {
                for (int l = 0; l < k[i]; l++) {
                    if (answers[i] > dist) {
                        answers[i] = dist;
                        break;
                    }
                }
            }
        }
        answers[i] = (count < k[i]) ? -1 : answers[i];
    }

    return answers;
}