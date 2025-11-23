long long waysToBuyPensPencils(int total, int cost1, int cost2){
    long long ways = 0;
    int maxPens = total / cost1;

    for (int pens = 0; pens <= maxPens; pens++) {
        int remaining = total - pens * cost1;
        ways += (remaining / cost2) + 1;
    }

    return ways;
}