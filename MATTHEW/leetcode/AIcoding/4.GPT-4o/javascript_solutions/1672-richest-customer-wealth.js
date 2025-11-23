var maximumWealth = function(accounts) {
    let maxWealth = 0;
    for (let account of accounts) {
        let wealth = account.reduce((a, b) => a + b, 0);
        maxWealth = Math.max(maxWealth, wealth);
    }
    return maxWealth;
};