long long waysToBuyPensPencils(int total, int cost1, int cost2) {
    long long count = 0;
    for (int i = 0; ; ++i) {
        long long moneySpentOnPens = (long long)i * cost1;
        if (moneySpentOnPens > total) {
            break;
        }
        long long remainingMoney = total - moneySpentOnPens;
        count += (remainingMoney / cost2) + 1;
    }
    return count;
}