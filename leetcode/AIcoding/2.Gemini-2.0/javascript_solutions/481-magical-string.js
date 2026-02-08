var magicalString = function(n) {
    if (n <= 0) return 0;
    if (n <= 3) return 1;

    const s = [1, 2, 2];
    let head = 2;
    let tail = 3;
    let num = 1;
    let count = 1;

    while (tail < n) {
        for (let i = 0; i < s[head]; i++) {
            s[tail++] = num;
            if (tail > n) break;
            if (num === 1) {
                count++;
            }
        }
        num = 3 - num;
        head++;
    }

    return count;
};