bool canReach(int* arr, int arrSize, int start) {
    if (start < 0 || start >= arrSize || arr[start] < 0) {
        return false;
    }
    if (arr[start] == 0) {
        return true;
    }

    int jump = arr[start];
    arr[start] = -1; // mark as visited

    return canReach(arr, arrSize, start + jump) || canReach(arr, arrSize, start - jump);
}