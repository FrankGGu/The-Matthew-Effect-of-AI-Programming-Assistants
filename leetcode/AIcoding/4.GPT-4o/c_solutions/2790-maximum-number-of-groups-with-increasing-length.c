int maxNumberOfGroups(int* graded, int gradedSize) {
    int sum = 0, count = 0;
    while (sum + count + 1 <= gradedSize) {
        count++;
        sum += count;
    }
    return count;
}