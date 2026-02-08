var maskPII = function(s) {
    if (s.includes('@')) {
        // Email
        s = s.toLowerCase();
        const atIndex = s.indexOf('@');
        const name = s.substring(0, atIndex);
        const domain = s.substring(atIndex);

        const maskedName = name[0] + '*****' + name[name.length - 1];
        return maskedName + domain;
    } else {
        // Phone Number
        let digits = '';
        for (let i = 0; i < s.length; i++) {
            if (s[i] >= '0' && s[i] <= '9') {
                digits += s[i];
            }
        }

        const n = digits.length;
        if (n === 10) {
            return `***-***-${digits.substring(6)}`;
        } else {
            let countryCodePrefix = '+';
            for (let i = 0; i < n - 10; i++) {
                countryCodePrefix += '*';
            }
            countryCodePrefix += '-';
            return `${countryCodePrefix}***-***-${digits.substring(n - 4)}`;
        }
    }
};