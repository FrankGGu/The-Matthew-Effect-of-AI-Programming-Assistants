var minimumCost = function(s) {
    let cost = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0' && (i === 0 || s[i - 1] === '1')) {
            cost++;
        } else if (s[i] === '1' && (i === 0 || s[i - 1] === '0')) {
            cost++;
        }
    }
    return cost;
};