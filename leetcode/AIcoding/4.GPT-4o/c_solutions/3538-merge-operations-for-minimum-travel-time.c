int minimumTravelTime(int* A, int ASize, int* B, int BSize) {
    long long total_time = 0;
    for (int i = 0; i < ASize; i++) {
        total_time += A[i];
    }

    long long min_time = total_time;
    for (int i = 0; i < BSize; i++) {
        long long temp_time = total_time;
        for (int j = 0; j < ASize; j++) {
            temp_time += (long long)B[i] - (long long)A[j];
            if (temp_time < min_time) {
                min_time = temp_time;
            }
        }
    }

    return (int)min_time;
}