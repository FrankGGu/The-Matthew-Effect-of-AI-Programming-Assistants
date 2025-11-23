var largestInteger = function(num) {
    const s = String(num);
    const n = s.length;
    const odd = [];
    const even = [];
    for (let i = 0; i < n; i++) {
        const digit = parseInt(s[i]);
        if (digit % 2 === 0) {
            even.push(digit);
        } else {
            odd.push(digit);
        }
    }
    odd.sort((a, b) => b - a);
    even.sort((a, b) => b - a);
    let oddIndex = 0;
    let evenIndex = 0;
    let result = "";
    for (let i = 0; i < n; i++) {
        const digit = parseInt(s[i]);
        if (digit % 2 === 0) {
            result += even[evenIndex];
            evenIndex++;
        } else {
            result += odd[oddIndex];
            oddIndex++;
        }
    }
    return parseInt(result);
};