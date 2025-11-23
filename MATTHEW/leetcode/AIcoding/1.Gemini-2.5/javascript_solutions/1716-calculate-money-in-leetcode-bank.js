var totalMoney = function(n) {
    let total = 0;
    let currentMondayValue = 1;

    for (let i = 0; i < n; i++) {
        let dayOfWeek = i % 7;
        let amount = currentMondayValue + dayOfWeek;
        total += amount;

        if (dayOfWeek === 6) {
            currentMondayValue++;
        }
    }

    return total;
};