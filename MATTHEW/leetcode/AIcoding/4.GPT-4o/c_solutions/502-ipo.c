typedef struct {
    int profit;
    int capital;
} Project;

int cmp(const void* a, const void* b) {
    Project* p1 = (Project*)a;
    Project* p2 = (Project*)b;
    return p2->profit - p1->profit;
}

int ipo(int k, int w, int* profits, int profitsSize, int* capital, int capitalSize) {
    Project projects[profitsSize];
    for (int i = 0; i < profitsSize; i++) {
        projects[i].profit = profits[i];
        projects[i].capital = capital[i];
    }

    qsort(projects, profitsSize, sizeof(Project), cmp);

    int i = 0;
    while (k > 0) {
        int maxProfit = -1;
        int index = -1;
        for (int j = 0; j < profitsSize; j++) {
            if (projects[j].capital <= w) {
                if (projects[j].profit > maxProfit) {
                    maxProfit = projects[j].profit;
                    index = j;
                }
            }
        }
        if (index == -1) break;
        w += projects[index].profit;
        projects[index].profit = -1;  // Mark as taken
        k--;
    }

    return w;
}