var countOdds = function(low, high) {
    if ((high - low + 1) % 2 === 0) {
        return (high - low + 1) / 2;
    } else {
        if (low % 2 !== 0 || high % 2 !== 0) {
            return Math.floor((high - low + 1) / 2) + 1;
        } else {
            return Math.floor((high - low + 1) / 2);
        }
    }
};