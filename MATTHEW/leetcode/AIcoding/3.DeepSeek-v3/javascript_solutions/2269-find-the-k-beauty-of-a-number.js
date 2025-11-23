var divisorSubstrings = function(num, k) {
    const numStr = num.toString();
    let count = 0;
    for (let i = 0; i <= numStr.length - k; i++) {
        const substring = numStr.substring(i, i + k);
        const subNum = parseInt(substring, 10);
        if (subNum !== 0 && num % subNum === 0) {
            count++;
        }
    }
    return count;
};