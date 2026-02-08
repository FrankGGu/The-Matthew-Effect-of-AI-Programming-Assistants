function maximumWealth(accounts) {
    let maxWealth = 0;
    for (let i = 0; i < accounts.length; i++) {
        let total = 0;
        for (let j = 0; j < accounts[i].length; j++) {
            total += accounts[i][j];
        }
        if (total > maxWealth) {
            maxWealth = total;
        }
    }
    return maxWealth;
}