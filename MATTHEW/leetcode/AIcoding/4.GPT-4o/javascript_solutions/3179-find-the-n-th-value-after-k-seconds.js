function NthValueAfterKSeconds(startValue, k, N) {
    let currentValue = startValue;
    for (let i = 0; i < k; i++) {
        currentValue += Math.floor(currentValue / 2);
    }
    for (let j = 0; j < N; j++) {
        currentValue += Math.floor(currentValue / 2);
    }
    return currentValue;
}