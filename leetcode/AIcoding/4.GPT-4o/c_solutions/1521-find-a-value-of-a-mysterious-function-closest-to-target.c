int closestToTarget(int* arr, int arrSize, int target) {
    int closest = arr[0];
    for (int i = 0; i < arrSize; i++) {
        int current = arr[i];
        for (int j = i; j < arrSize; j++) {
            current &= arr[j];
            if (abs(current - target) < abs(closest - target) || 
                (abs(current - target) == abs(closest - target) && current > closest)) {
                closest = current;
            }
            if (current == 0) break;
        }
    }
    return closest;
}