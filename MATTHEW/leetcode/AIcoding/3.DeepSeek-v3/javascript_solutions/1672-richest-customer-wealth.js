var maximumWealth = function(accounts) {
    let maxWealth = 0;
    for (let customer of accounts) {
        let currentWealth = customer.reduce((a, b) => a + b, 0);
        if (currentWealth > maxWealth) {
            maxWealth = currentWealth;
        }
    }
    return maxWealth;
};