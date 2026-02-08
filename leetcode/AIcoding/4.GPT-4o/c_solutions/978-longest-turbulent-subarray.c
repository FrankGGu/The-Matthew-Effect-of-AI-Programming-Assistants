int maxTurbulenceSize(int* arr, int arrSize) {
    if (arrSize < 2) return arrSize;

    int max_length = 1, current_length = 1;
    int direction = 0; // 0: no direction, 1: up, -1: down

    for (int i = 1; i < arrSize; i++) {
        if (arr[i] > arr[i - 1]) {
            if (direction <= 0) {
                current_length++;
                direction = 1;
            } else {
                current_length = 2;
            }
        } else if (arr[i] < arr[i - 1]) {
            if (direction >= 0) {
                current_length++;
                direction = -1;
            } else {
                current_length = 2;
            }
        } else {
            current_length = 1;
            direction = 0;
        }
        if (current_length > max_length) {
            max_length = current_length;
        }
    }

    return max_length;
}