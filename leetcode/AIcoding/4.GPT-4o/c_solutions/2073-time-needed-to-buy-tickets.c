int timeRequiredToBuy(int* tickets, int ticketsSize, int k) {
    int time = 0;
    for (int i = 0; i < ticketsSize; i++) {
        if (i <= k) {
            time += tickets[i] < tickets[k] ? tickets[i] : tickets[k];
        } else {
            time += tickets[k] < tickets[i] ? tickets[k] : tickets[i];
        }
    }
    return time;
}