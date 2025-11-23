function magicalSum(arr) {
    let n = arr.length;
    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let product = 1;
            for (let k = i; k <= j; k++) {
                product *= arr[k];
            }
            totalSum += product;
        }
    }
    return totalSum;
}