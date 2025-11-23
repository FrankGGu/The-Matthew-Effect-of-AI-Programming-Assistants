var punishmentNumber = function(n) {
    let totalPunishmentSum = 0;

    const canPartition = (s, target, index, currentSum) => {
        if (currentSum > target) {
            return false;
        }
        if (index === s.length) {
            return currentSum === target;
        }

        let num = 0;
        for (let i = index; i < s.length; i++) {
            num = num * 10 + parseInt(s[i]);
            if (canPartition(s, target, i + 1, currentSum + num)) {
                return true;
            }
        }
        return false;
    };

    for (let i = 1; i <= n; i++) {
        const square = i * i;
        const s = String(square);
        if (canPartition(s, i, 0, 0)) {
            totalPunishmentSum += i;
        }
    }

    return totalPunishmentSum;
};