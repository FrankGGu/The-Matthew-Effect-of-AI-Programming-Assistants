var punishmentNumber = function(n) {
    let res = 0;
    for (let i = 1; i <= n; i++) {
        const square = i * i;
        if (canPartition(square.toString(), i)) {
            res += square;
        }
    }
    return res;
};

function canPartition(s, target) {
    if (s === "") {
        return target === 0;
    }
    for (let i = 1; i <= s.length; i++) {
        const num = parseInt(s.substring(0, i));
        if (num > target) {
            break;
        }
        if (canPartition(s.substring(i), target - num)) {
            return true;
        }
    }
    return false;
}