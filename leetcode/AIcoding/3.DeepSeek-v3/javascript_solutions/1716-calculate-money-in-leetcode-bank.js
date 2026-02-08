var totalMoney = function(n) {
    let total = 0;
    let weeks = Math.floor(n / 7);
    let remainingDays = n % 7;

    for (let i = 1; i <= weeks; i++) {
        total += 28 + (i - 1) * 7;
    }

    for (let i = 1; i <= remainingDays; i++) {
        total += weeks + i;
    }

    return total;
};