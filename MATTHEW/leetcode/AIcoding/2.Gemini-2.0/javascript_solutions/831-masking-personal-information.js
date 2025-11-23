var maskPII = function(s) {
    if (s.includes('@')) {
        const parts = s.toLowerCase().split('@');
        const local = parts[0];
        const domain = parts[1];
        return local[0] + "*****" + local[local.length - 1] + "@" + domain;
    } else {
        const digits = s.replace(/[^0-9]/g, '');
        const n = digits.length;
        const lastFour = digits.slice(n - 4);
        let maskedNumber = "***-***-" + lastFour;
        if (n > 10) {
            let countryCode = "";
            for (let i = 0; i < n - 10; i++) {
                countryCode += "*";
            }
            maskedNumber = "+" + countryCode + "-" + maskedNumber;
        }
        return maskedNumber;
    }
};