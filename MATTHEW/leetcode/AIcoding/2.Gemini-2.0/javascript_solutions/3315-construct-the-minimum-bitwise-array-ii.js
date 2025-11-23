var constructArray = function(n, k) {
    const result = new Array(n);
    let left = 1;
    let right = k + 1;
    let index = 0;
    let toggle = true;

    while (left <= right) {
        if (toggle) {
            result[index++] = left++;
        } else {
            result[index++] = right--;
        }
        toggle = !toggle;
    }

    for (let i = k + 2; i <= n; i++) {
        result[index++] = i;
    }

    return result;
};