int findClosestPerson(int* people, int peopleSize, int target) {
    int closestIndex = -1;
    int minDiff = INT_MAX;

    for (int i = 0; i < peopleSize; i++) {
        if (people[i] == target) {
            return i;
        }
        int diff = abs(people[i] - target);
        if (diff < minDiff) {
            minDiff = diff;
            closestIndex = i;
        }
    }

    return closestIndex;
}