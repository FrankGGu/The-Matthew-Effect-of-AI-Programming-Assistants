var waysToBuyPensPencils = function(total, cost1, cost2) {
    let ways = 0;
    for (let i = 0; i * cost1 <= total; i++) {
        ways += Math.floor((total - i * cost1) / cost2) + 1;
    }
    return ways;
};