function miceAndCheese(reward1, reward2) {
    const n = reward1.length;
    const diff = [];
    for (let i = 0; i < n; i++) {
        diff.push(reward1[i] - reward2[i]);
    }
    diff.sort((a, b) => b - a);
    let total = 0;
    for (let i = 0; i < n; i++) {
        if (i < n / 2) {
            total += reward1[i];
        } else {
            total += reward2[i];
        }
    }
    return total;
}