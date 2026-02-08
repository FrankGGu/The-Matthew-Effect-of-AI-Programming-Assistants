var countLargestGroup = function(n) {
    const count = new Array(37).fill(0);

    for (let i = 1; i <= n; i++) {
        let sum = 0;
        let num = i;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        count[sum]++;
    }

    const maxCount = Math.max(...count);
    return count.filter(x => x === maxCount).length;
};