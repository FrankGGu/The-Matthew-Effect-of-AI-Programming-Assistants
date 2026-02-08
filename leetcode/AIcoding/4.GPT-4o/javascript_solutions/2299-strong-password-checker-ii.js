function strongPasswordCheckerII(password) {
    const n = password.length;
    if (n < 8) return false;

    const hasLower = /[a-z]/.test(password);
    const hasUpper = /[A-Z]/.test(password);
    const hasDigit = /\d/.test(password);
    const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);

    let hasNoSameAdjacent = true;
    for (let i = 1; i < n; i++) {
        if (password[i] === password[i - 1]) {
            hasNoSameAdjacent = false;
            break;
        }
    }

    return hasLower && hasUpper && hasDigit && hasSpecial && hasNoSameAdjacent;
}