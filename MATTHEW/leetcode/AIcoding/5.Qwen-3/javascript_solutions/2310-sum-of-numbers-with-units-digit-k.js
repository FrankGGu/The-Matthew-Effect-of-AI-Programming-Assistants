function minimumSum(k, n) {
    let sum = 0;
    let count = 0;
    let num = 1;

    while (count < n) {
        if (num % 10 === k) {
            sum += num;
            count++;
        }
        num++;
    }

    return sum;
}