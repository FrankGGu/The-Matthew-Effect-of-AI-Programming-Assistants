var constructArray = function(n, k) {
    const result = [];
    let left = 1;
    let right = k + 1;
    let isIncreasing = true;

    while (left <= right) {
        if (isIncreasing) {
            result.push(left);
            left++;
        } else {
            result.push(right);
            right--;
        }
        isIncreasing = !isIncreasing;
    }

    for (let i = k + 2; i <= n; i++) {
        result.push(i);
    }

    return result;
};