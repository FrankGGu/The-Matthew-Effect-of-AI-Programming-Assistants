var miceAndCheese = function(reward1, reward2, k) {
    const n = reward1.length;
    const diff = [];
    for (let i = 0; i < n; i++) {
        diff.push([reward1[i] - reward2[i], i]);
    }
    diff.sort((a, b) => b[0] - a[0]);

    let res = 0;
    for (let i = 0; i < k; i++) {
        res += reward1[diff[i][1]];
    }
    for (let i = k; i < n; i++) {
        res += reward2[diff[i][1]];
    }
    return res;
};