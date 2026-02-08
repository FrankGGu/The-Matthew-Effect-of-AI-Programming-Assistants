var maskPII = function(s) {
    if (s.includes('@')) {
        const parts = s.toLowerCase().split('@');
        const name = parts[0];
        const domain = parts[1];
        const maskedName = name[0] + '*****' + name[name.length - 1];
        return maskedName + '@' + domain;
    } else {
        const digits = s.replace(/[^0-9]/g, '');
        const localNum = '***-***-' + digits.substring(digits.length - 4);
        if (digits.length === 10) {
            return localNum;
        } else {
            const countryCode = '+' + '*'.repeat(digits.length - 10) + '-';
            return countryCode + localNum;
        }
    }
};