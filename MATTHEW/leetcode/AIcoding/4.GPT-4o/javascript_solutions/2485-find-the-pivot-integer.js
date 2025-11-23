function pivotInteger(n) {
    const totalSum = (n * (n + 1)) / 2;
    let leftSum = 0;

    for (let i = 1; i <= n; i++) {
        leftSum += i;
        const rightSum = totalSum - leftSum + i;
        if (leftSum === rightSum) {
            return i;
        }
    }
    return -1;
}