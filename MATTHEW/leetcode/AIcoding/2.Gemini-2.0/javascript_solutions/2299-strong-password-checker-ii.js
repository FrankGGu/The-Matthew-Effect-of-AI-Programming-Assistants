var strongPasswordCheckerII = function(password) {
    if (password.length < 8) return false;
    let hasLower = false;
    let hasUpper = false;
    let hasDigit = false;
    let hasSpecial = false;
    const specialChars = "!@#$%^&*()-+";

    for (let i = 0; i < password.length; i++) {
        const char = password[i];
        if (/[a-z]/.test(char)) hasLower = true;
        if (/[A-Z]/.test(char)) hasUpper = true;
        if (/[0-9]/.test(char)) hasDigit = true;
        if (specialChars.includes(char)) hasSpecial = true;

        if (i > 0 && password[i] === password[i - 1]) return false;
    }

    return hasLower && hasUpper && hasDigit && hasSpecial;
};