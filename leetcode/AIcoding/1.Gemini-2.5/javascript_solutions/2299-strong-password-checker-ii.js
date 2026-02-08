var strongPasswordCheckerII = function(password) {
    if (password.length < 8) {
        return false;
    }

    let hasLower = false;
    let hasUpper = false;
    let hasDigit = false;
    let hasSpecial = false;

    const specialChars = "!@#$%^&*()-+";

    for (let i = 0; i < password.length; i++) {
        const char = password[i];

        if (char >= 'a' && char <= 'z') {
            hasLower = true;
        } else if (char >= 'A' && char <= 'Z') {
            hasUpper = true;
        } else if (char >= '0' && char <= '9') {
            hasDigit = true;
        } else if (specialChars.includes(char)) {
            hasSpecial = true;
        }

        if (i > 0 && char === password[i - 1]) {
            return false;
        }
    }

    return hasLower && hasUpper && hasDigit && hasSpecial;
};