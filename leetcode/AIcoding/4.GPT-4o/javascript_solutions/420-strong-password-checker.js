function strongPasswordChecker(s) {
    const n = s.length;
    let hasLower = false, hasUpper = false, hasDigit = false;
    let replace = 0, oneRepeat = 0, twoRepeat = 0;

    for (let i = 0; i < n; i++) {
        const char = s[i];
        if (/[a-z]/.test(char)) hasLower = true;
        if (/[A-Z]/.test(char)) hasUpper = true;
        if (/\d/.test(char)) hasDigit = true;

        if (i > 1 && char === s[i - 1] && char === s[i - 2]) {
            replace++;
            twoRepeat++;
            i += 2; // skip the next two characters since they are the same
        } else if (i > 0 && char === s[i - 1]) {
            oneRepeat++;
        } else {
            if (oneRepeat > 0) {
                replace++;
                oneRepeat = 0;
            }
        }
    }

    const missingTypes = !hasLower + !hasUpper + !hasDigit;

    if (n < 6) {
        return Math.max(6 - n, missingTypes);
    } else if (n <= 20) {
        return Math.max(replace, missingTypes);
    } else {
        const excess = n - 20;
        let reductions = Math.min(excess, twoRepeat * 2) / 2;
        replace -= reductions;
        reductions = Math.min(Math.max(excess - 2 * twoRepeat, 0), oneRepeat);
        replace -= reductions;
        reductions = Math.max(excess - 2 * twoRepeat - oneRepeat, 0) / 3;
        replace -= reductions;
        return excess + Math.max(replace, missingTypes);
    }
}