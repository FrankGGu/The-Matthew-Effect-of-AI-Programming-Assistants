function countGoodIntegers(n) {
    let count = 0;
    for (let i = 1; i <= n; i++) {
        let s = i.toString();
        let sum = 0;
        for (let j = 0; j < s.length; j++) {
            sum += parseInt(s[j]);
        }
        if (sum % 3 === 0) {
            count++;
        }
    }
    return count;
}