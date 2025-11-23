var waysToBuyPensPencils = function(total, cost1, cost2) {
    let count = 0;
    for (let i = 0; i <= Math.floor(total / cost1); i++) {
        count += Math.floor((total - i * cost1) / cost2) + 1;
    }
    return count;
};