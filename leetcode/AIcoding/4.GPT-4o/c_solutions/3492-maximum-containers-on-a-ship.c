int maxContainers(int* container, int containerSize, int maxWeight) {
    int count = 0;
    int left = 0, right = containerSize - 1;

    qsort(container, containerSize, sizeof(int), cmp);

    while (left <= right) {
        if (container[left] + container[right] <= maxWeight) {
            left++;
        }
        right--;
        count++;
    }

    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}