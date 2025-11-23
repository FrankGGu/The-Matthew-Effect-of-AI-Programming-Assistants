var countKReductionNumbers = function(n, k) {
    let count = 0;
    for (let i = 1; i < n; i++) {
        let num = i;
        let steps = 0;
        while (num >= 10) {
            let sum = 0;
            let temp = num;
            while (temp > 0) {
                sum += temp % 10;
                temp = Math.floor(temp / 10);
            }
            num = sum;
            steps++;
        }
        if (num < k) {
            count++;
        }
    }
    return count;
};