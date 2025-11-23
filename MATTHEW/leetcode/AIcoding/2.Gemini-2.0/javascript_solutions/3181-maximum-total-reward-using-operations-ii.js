var maximumTotalReward = function(reward, k) {
    const n = reward.length;
    reward.sort((a, b) => a - b);
    let sum = 0;
    for (let i = n - 1; i >= n - k; i--) {
        sum += reward[i];
    }
    return sum;
};