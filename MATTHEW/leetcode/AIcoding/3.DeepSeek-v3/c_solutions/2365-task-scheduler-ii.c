typedef long long ll;

long long taskSchedulerII(int* tasks, int tasksSize, int space) {
    ll day = 0;
    ll* last = (ll*)calloc(100001, sizeof(ll));

    for (int i = 0; i < tasksSize; i++) {
        day++;
        if (last[tasks[i]] != 0 && day - last[tasks[i]] <= space) {
            day = last[tasks[i]] + space + 1;
        }
        last[tasks[i]] = day;
    }

    free(last);
    return day;
}