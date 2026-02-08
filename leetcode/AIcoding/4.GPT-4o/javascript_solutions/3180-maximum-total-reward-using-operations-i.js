function maximumReward(operations) {
    let totalReward = 0;
    let availableRewards = [];

    for (let op of operations) {
        if (op[0] === 1) {
            availableRewards.push(op[1]);
        } else if (op[0] === 2) {
            if (availableRewards.length > 0) {
                totalReward += Math.max(...availableRewards);
                availableRewards.splice(availableRewards.indexOf(Math.max(...availableRewards)), 1);
            }
        }
    }

    return totalReward;
}