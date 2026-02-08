var strongPasswordCheckerII = function(password) {
    if (password.length < 8) return false;

    let hasLower = false;
    let hasUpper = false;
    let hasDigit = false;
    let hasSpecial = false;
    const specialChars = "!@#$%^&*()-+";

    for (let i = 0; i < password.length; i++) {
        const c = password[i];
        if (i > 0 && password[i] === password[i - 1]) {
            return false;
        }
        if (c >= 'a' && c <= 'z') {
            hasLower = true;
        } else if (c >= 'A' && c <= 'Z') {
            hasUpper = true;
        } else if (c >= '0' && c <= '9') {
            hasDigit = true;
        } else if (specialChars.includes(c)) {
            hasSpecial = true;
        }
    }

    return hasLower && hasUpper && hasDigit && hasSpecial;
};