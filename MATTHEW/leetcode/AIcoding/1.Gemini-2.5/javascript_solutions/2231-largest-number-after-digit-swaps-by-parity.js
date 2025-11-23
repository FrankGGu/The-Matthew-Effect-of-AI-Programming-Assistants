var largestInteger = function(num) {
    const s = String(num);
    const n = s.length;

    const oddDigits = [];
    const evenDigits = [];
    const parityMap = new Array(n); // 0 for even, 1 for odd

    for (let i = 0; i < n; i++) {
        const digit = parseInt(s[i]);
        if (digit % 2 === 0) {
            evenDigits.push(digit);
            parityMap[i] = 0;
        } else {
            oddDigits.push(digit);
            parityMap[i] = 1;
        }
    }

    oddDigits.sort((a, b) => b - a); // Sort descending
    evenDigits.sort((a, b) => b - a); // Sort descending

    let oddIdx = 0;
    let evenIdx = 0;
    const result = new Array(n);

    for (let i = 0; i < n; i++) {
        if (parityMap[i] === 0) { // Original position was even
            result[i] = evenDigits[evenIdx];
            evenIdx++;
        } else { // Original position was odd
            result[i] = oddDigits[oddIdx];
            oddIdx++;
        }
    }

    return parseInt(result.join(''));
};