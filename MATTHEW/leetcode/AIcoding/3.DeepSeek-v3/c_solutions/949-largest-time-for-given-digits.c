char * largestTimeFromDigits(int* arr, int arrSize){
    int maxTime = -1;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (j == i) continue;
            for (int k = 0; k < 4; k++) {
                if (k == i || k == j) continue;
                int l = 6 - i - j - k;
                int hours = arr[i] * 10 + arr[j];
                int minutes = arr[k] * 10 + arr[l];
                if (hours < 24 && minutes < 60) {
                    int total = hours * 60 + minutes;
                    if (total > maxTime) {
                        maxTime = total;
                    }
                }
            }
        }
    }

    if (maxTime == -1) {
        char* result = (char*)malloc(1);
        result[0] = '\0';
        return result;
    }

    char* result = (char*)malloc(6 * sizeof(char));
    sprintf(result, "%02d:%02d", maxTime / 60, maxTime % 60);
    return result;
}