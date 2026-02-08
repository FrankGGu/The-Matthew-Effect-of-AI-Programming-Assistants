var threeConsecutiveOdds = function(arr) {
    let consecutiveOdds = 0;
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] % 2 !== 0) {
            consecutiveOdds++;
            if (consecutiveOdds === 3) {
                return true;
            }
        } else {
            consecutiveOdds = 0;
        }
    }
    return false;
};