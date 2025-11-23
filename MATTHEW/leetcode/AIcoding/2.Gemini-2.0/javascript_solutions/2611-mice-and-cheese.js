var miceAndCheese = function(reward1, reward2, k) {
    let n = reward1.length;
    let diff = [];
    for (let i = 0; i < n; i++) {
        diff.push([reward1[i] - reward2[i], i]);
    }
    diff.sort((a, b) => b[0] - a[0]);

    let totalReward = 0;
    for (let i = 0; i < k; i++) {
        totalReward += reward1[diff[i][1]];
    }
    for (let i = k; i < n; i++) {
        totalReward += reward2[diff[i][1]];
    }

    return totalReward;
};