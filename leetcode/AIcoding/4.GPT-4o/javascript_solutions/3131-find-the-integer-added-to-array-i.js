function findTheInteger(arr) {
    let n = arr.length;
    let sum = 0;
    let total = n * (n + 1) / 2;

    for (let num of arr) {
        sum += num;
    }

    return total - sum;
}