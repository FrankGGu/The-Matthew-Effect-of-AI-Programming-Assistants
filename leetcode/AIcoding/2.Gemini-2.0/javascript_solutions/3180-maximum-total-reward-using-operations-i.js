var maxTotalReward = function(reward, k) {
    reward.sort((a, b) => b - a);
    let totalReward = 0;
    for (let i = 0; i < Math.min(k, reward.length); i++) {
        totalReward += reward[i];
    }
    return totalReward;
};