function minCost(s) {
    let cost = 0;
    let i = 0;
    while (i < s.length) {
        let j = i;
        while (j < s.length && s[j] === s[i]) {
            j++;
        }
        const count = j - i;
        if (count > 1) {
            cost += Math.floor(count / 2);
        }
        i = j;
    }
    return cost;
}