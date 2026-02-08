var miceAndCheese = function(reward1, reward2, k) {
    const n = reward1.length;
    let totalReward = 0;
    const diffs = new Array(n);

    for (let i = 0; i < n; i++) {
        diffs[i] = reward1[i] - reward2[i];
        totalReward += reward2[i];
    }

    diffs.sort((a, b) => b - a);

    for (let i = 0; i < k; i++) {
        totalReward += diffs[i];
    }

    return totalReward;
};