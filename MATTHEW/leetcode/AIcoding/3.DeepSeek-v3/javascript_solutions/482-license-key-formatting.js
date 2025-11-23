var licenseKeyFormatting = function(s, k) {
    const cleaned = s.replace(/-/g, '').toUpperCase();
    const len = cleaned.length;
    let result = [];
    let firstGroupLength = len % k;

    if (firstGroupLength > 0) {
        result.push(cleaned.substring(0, firstGroupLength));
    }

    for (let i = firstGroupLength; i < len; i += k) {
        result.push(cleaned.substring(i, i + k));
    }

    return result.join('-');
};