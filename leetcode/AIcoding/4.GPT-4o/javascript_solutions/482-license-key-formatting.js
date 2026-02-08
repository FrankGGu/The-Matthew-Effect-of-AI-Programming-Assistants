var licenseKeyFormatting = function(S, K) {
    S = S.replace(/-/g, '').toUpperCase();
    let result = '';
    let n = S.length;

    for (let i = n - 1; i >= 0; i--) {
        if (result.length && (result.length % (K + 1)) === K) {
            result = '-' + result;
        }
        result = S[i] + result;
    }

    return result;
};