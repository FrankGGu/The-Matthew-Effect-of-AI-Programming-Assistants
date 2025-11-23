int minOperationsMaxProfit(int* customers, int customersSize, int boardingCost, int runningCost) {
    if (boardingCost * 4 <= runningCost) return -1;

    int max_profit = 0;
    int max_rotation = -1;
    int current_profit = 0;
    int waiting = 0;
    int rotation = 0;
    int i = 0;

    while (waiting > 0 || i < customersSize) {
        if (i < customersSize) {
            waiting += customers[i];
            i++;
        }

        int board = waiting < 4 ? waiting : 4;
        waiting -= board;
        current_profit += board * boardingCost - runningCost;
        rotation++;

        if (current_profit > max_profit) {
            max_profit = current_profit;
            max_rotation = rotation;
        }
    }

    return max_profit > 0 ? max_rotation : -1;
}