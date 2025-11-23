function minNumberOperations(target) {
    let res = 0;
    for (let i = 0; i < target.length; i++) {
        if (i === 0 || target[i] > target[i - 1]) {
            res += target[i] - target[i - 1];
        }
    }
    return res;
}