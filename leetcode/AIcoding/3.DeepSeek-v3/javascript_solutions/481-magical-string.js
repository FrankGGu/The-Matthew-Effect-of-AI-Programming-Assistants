var magicalString = function(n) {
    if (n === 0) return 0;
    if (n <= 3) return 1;

    let s = [1, 2, 2];
    let index = 2;
    let count = 1;

    while (s.length < n) {
        const nextNum = s[s.length - 1] === 1 ? 2 : 1;
        const repeat = s[index];
        for (let i = 0; i < repeat; i++) {
            s.push(nextNum);
            if (nextNum === 1 && s.length <= n) {
                count++;
            }
        }
        index++;
    }

    return count;
};