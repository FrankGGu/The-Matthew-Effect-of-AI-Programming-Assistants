int timeRequiredToBuy(int* tickets, int ticketsSize, int k) {
    int time = 0;
    int targetTickets = tickets[k];

    for (int i = 0; i < ticketsSize; i++) {
        if (i <= k) {
            time += (tickets[i] < targetTickets) ? tickets[i] : targetTickets;
        } else {
            time += (tickets[i] < targetTickets - 1) ? tickets[i] : (targetTickets - 1);
        }
    }
    return time;
}