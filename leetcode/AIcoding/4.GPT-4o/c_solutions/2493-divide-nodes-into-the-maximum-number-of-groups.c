#define MAXN 100005

int maxGroups(int* grades, int gradesSize) {
    int count = 0;
    int total = 0;

    for (int i = 1; total + i <= gradesSize; i++) {
        total += i;
        count++;
    }

    return count;
}