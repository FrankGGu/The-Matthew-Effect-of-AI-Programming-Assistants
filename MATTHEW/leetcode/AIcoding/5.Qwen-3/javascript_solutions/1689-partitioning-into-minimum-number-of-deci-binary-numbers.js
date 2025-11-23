function minPartitions(n) {
    let maxDigit = 0;
    for (let i = 0; i < n.length; i++) {
        maxDigit = Math.max(maxDigit, parseInt(n[i]));
    }
    return maxDigit;
}