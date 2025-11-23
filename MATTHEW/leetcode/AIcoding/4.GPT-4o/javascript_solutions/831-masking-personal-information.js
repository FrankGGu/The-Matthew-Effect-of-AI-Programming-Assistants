var maskPII = function(S) {
    let atIndex = S.indexOf('@');
    if (atIndex !== -1) {
        let name = S.slice(0, atIndex).toLowerCase();
        let domain = S.slice(atIndex + 1).toLowerCase();
        return `${name[0]}*****${name[name.length - 1]}@${domain}`;
    } else {
        let digits = S.replace(/\D/g, '');
        let maskedNumber = `***-***-`;
        if (digits.length > 10) {
            maskedNumber = `+${'*'.repeat(digits.length - 10)}-${maskedNumber}`;
        }
        maskedNumber += digits.slice(-4);
        return maskedNumber;
    }
};