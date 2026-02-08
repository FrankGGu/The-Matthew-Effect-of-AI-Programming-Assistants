function reformatNumber(number) {
    const digits = number.replace(/[^0-9]/g, '');
    const n = digits.length;
    let result = '';
    for (let i = 0; i < n; i += 3) {
        if (i + 3 <= n - 2) {
            result += digits.substring(i, i + 3) + '-';
        } else {
            result += digits.substring(i);
        }
    }
    return result;
}