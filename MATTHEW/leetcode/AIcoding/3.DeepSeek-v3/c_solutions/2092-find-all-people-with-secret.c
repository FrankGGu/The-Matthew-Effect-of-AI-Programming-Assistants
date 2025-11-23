/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int person;
    int time;
} Event;

int cmp(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    return e1->time - e2->time;
}

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int* findAllPeople(int n, int** meetings, int meetingsSize, int* meetingsColSize, int firstPerson, int* returnSize) {
    Event* events = (Event*)malloc(meetingsSize * 2 * sizeof(Event));
    int eventsSize = 0;

    for (int i = 0; i < meetingsSize; i++) {
        events[eventsSize].person = meetings[i][0];
        events[eventsSize].time = meetings[i][2];
        eventsSize++;
        events[eventsSize].person = meetings[i][1];
        events[eventsSize].time = meetings[i][2];
        eventsSize++;
    }

    qsort(events, eventsSize, sizeof(Event), cmp);

    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }
    unionSet(parent, rank, 0, firstPerson);

    int* secretKnown = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) secretKnown[i] = 0;
    secretKnown[0] = 1;
    secretKnown[firstPerson] = 1;

    for (int i = 0; i < eventsSize; ) {
        int currentTime = events[i].time;

        int* tempParent = (int*)malloc(n * sizeof(int));
        int* tempRank = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            tempParent[j] = parent[j];
            tempRank[j] = rank[j];
        }

        int j = i;
        while (j < eventsSize && events[j].time == currentTime) {
            int p1 = events[j].person;
            j++;
            int p2 = events[j].person;
            j++;
            unionSet(tempParent, tempRank, p1, p2);
        }

        int root0 = find(tempParent, 0);
        for (int k = i; k < j; k++) {
            int person = events[k].person;
            if (find(tempParent, person) == root0) {
                secretKnown[person] = 1;
                unionSet(parent, rank, 0, person);
            }
        }

        free(tempParent);
        free(tempRank);
        i = j;
    }

    int* result = (int*)malloc(n * sizeof(int));
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (secretKnown[i]) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    free(events);
    free(parent);
    free(rank);
    free(secretKnown);
    return result;
}