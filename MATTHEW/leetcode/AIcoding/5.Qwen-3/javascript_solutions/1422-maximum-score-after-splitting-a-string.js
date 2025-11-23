function maxScore(s) {
    let max = 0;
    let leftZero = 0;
    let leftOne = 0;
    for (let i = 0; i < s.length - 1; i++) {
        if (s[i] === '0') {
            leftZero++;
        } else {
            leftOne++;
        }
        const rightZero = (s.length - 1 - i) - leftZero;
        const rightOne = (s.length - i - 1) - rightZero;
        max = Math.max(max, leftZero + rightOne);
    }
    return max;
}