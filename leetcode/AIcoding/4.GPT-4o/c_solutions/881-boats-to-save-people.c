int numRescueBoats(int* people, int peopleSize, int limit) {
    qsort(people, peopleSize, sizeof(int), cmp);
    int left = 0, right = peopleSize - 1, boats = 0;

    while (left <= right) {
        if (people[left] + people[right] <= limit) {
            left++;
        }
        right--;
        boats++;
    }

    return boats;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}