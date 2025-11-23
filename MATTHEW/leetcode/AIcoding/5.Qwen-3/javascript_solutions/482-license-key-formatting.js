function licenseKeyFormatting(s, k) {
    s = s.replace(/-/g, '').toUpperCase();
    let result = [];
    let count = 0;
    for (let i = s.length - 1; i >= 0; i--) {
        result.push(s[i]);
        count++;
        if (count % k === 0 && i !== 0) {
            result.push('-');
        }
    }
    return result.reverse().join('');
}