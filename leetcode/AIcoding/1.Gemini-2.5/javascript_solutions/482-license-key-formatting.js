var licenseKeyFormatting = function(s, k) {
    let cleanedS = '';
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== '-') {
            cleanedS += s[i].toUpperCase();
        }
    }

    if (cleanedS.length === 0) {
        return "";
    }

    let result = [];
    let firstGroupLen = cleanedS.length % k;

    if (firstGroupLen > 0) {
        result.push(cleanedS.substring(0, firstGroupLen));
    }

    for (let i = firstGroupLen; i < cleanedS.length; i += k) {
        result.push(cleanedS.substring(i, i + k));
    }

    return result.join('-');
};