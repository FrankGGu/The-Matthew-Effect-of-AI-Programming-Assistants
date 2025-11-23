var licenseKeyFormatting = function(s, k) {
    const str = s.replace(/-/g, '').toUpperCase();
    let result = '';
    let count = 0;
    for (let i = str.length - 1; i >= 0; i--) {
        result = str[i] + (count === k - 1 && i !== 0 ? '-' : '') + result;
        count = (count + 1) % k;
    }
    return result;
};