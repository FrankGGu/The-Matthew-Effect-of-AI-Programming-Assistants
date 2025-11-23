function magicalString(n) {
    if (n === 0) return 0;
    if (n <= 3) return 1;

    let s = '122';
    let count = 1;
    let index = 2;

    while (s.length < n) {
        let num = s[index] - '0';
        s += '1'.repeat(num);
        if (s.length < n) {
            s += '2'.repeat(num);
        }
        index++;
    }

    return s.slice(0, n).split('').filter(x => x === '1').length;
}