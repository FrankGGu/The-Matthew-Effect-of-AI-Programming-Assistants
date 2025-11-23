function divisibilityArray(num) {
    const n = num.length;
    const result = [];
    let remainder = 0;
    for (let i = 0; i < n; i++) {
        remainder = (remainder * 10 + parseInt(num[i])) % (i + 1);
        result.push(remainder === 0 ? 1 : 0);
    }
    return result;
}