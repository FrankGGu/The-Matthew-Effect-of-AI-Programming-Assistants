function kthSmallestInstructions(n, k) {
    let total = n * 2;
    let result = [];
    let left = n;
    let right = n;
    let factorial = new Array(total + 1).fill(1);
    for (let i = 1; i <= total; i++) {
        factorial[i] = factorial[i - 1] * i;
    }
    while (left > 0 || right > 0) {
        if (left === 0) {
            result.push('R');
            right--;
            continue;
        }
        if (right === 0) {
            result.push('L');
            left--;
            continue;
        }
        let count = factorial[left + right - 1] / (factorial[left] * factorial[right - 1]);
        if (k <= count) {
            result.push('L');
            left--;
        } else {
            result.push('R');
            k -= count;
            right--;
        }
    }
    return result.join('');
}