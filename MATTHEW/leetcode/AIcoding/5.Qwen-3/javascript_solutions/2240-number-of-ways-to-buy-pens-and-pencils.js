function waysToBuyPensPencils(total, cost1, cost2) {
    let count = 0;
    for (let i = 0; i * cost1 <= total; i++) {
        let remaining = total - i * cost1;
        count += Math.floor(remaining / cost2) + 1;
    }
    return count;
}