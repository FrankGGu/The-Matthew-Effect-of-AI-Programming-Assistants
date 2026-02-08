int averageWaitingTime(int** customers, int customersSize, int* customersColSize) {
    long long total_wait = 0;
    int current_time = 0;

    for (int i = 0; i < customersSize; i++) {
        int arrival = customers[i][0];
        int prep_time = customers[i][1];

        if (current_time < arrival) {
            current_time = arrival;
        }

        int finish_time = current_time + prep_time;
        total_wait += finish_time - arrival;
        current_time = finish_time;
    }

    return total_wait / customersSize;
}