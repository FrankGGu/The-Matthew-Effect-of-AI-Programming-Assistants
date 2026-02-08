int getLastMoment(int n, int* left, int leftSize, int* right, int rightSize) {
    int max_time = 0;

    for (int i = 0; i < leftSize; i++) {
        if (left[i] > max_time) {
            max_time = left[i];
        }
    }

    for (int i = 0; i < rightSize; i++) {
        int time_to_fall = n - right[i];
        if (time_to_fall > max_time) {
            max_time = time_to_fall;
        }
    }

    return max_time;
}