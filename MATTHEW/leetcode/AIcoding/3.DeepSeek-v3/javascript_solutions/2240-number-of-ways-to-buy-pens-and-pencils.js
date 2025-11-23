var waysToBuyPensPencils = function(total, cost1, cost2) {
    let ways = 0;
    for (let pens = 0; pens * cost1 <= total; pens++) {
        let remaining = total - pens * cost1;
        let maxPencils = Math.floor(remaining / cost2);
        ways += maxPencils + 1;
    }
    return ways;
};