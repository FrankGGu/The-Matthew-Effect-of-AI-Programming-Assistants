function countLargestGroup(n) {
    const count = new Array(10).fill(0);
    for (let i = 1; i <= n; i++) {
        let sum = 0;
        let num = i;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        count[sum]++;
    }
    let max = 0;
    for (let i = 0; i < 10; i++) {
        if (count[i] > max) {
            max = count[i];
        }
    }
    let result = 0;
    for (let i = 0; i < 10; i++) {
        if (count[i] === max) {
            result++;
        }
    }
    return result;
}