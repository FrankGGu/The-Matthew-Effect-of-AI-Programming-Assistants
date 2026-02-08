function largestMultipleOfThree(digits) {
    digits.sort((a, b) => b - a);
    const sum = digits.reduce((s, d) => s + d, 0);
    if (sum % 3 === 0) {
        return digits.length === 0 ? "0" : digits.join("");
    }
    const mod1 = [];
    const mod2 = [];
    for (const d of digits) {
        if (d % 3 === 1) mod1.push(d);
        else if (d % 3 === 2) mod2.push(d);
    }
    if (sum % 3 === 1) {
        if (mod1.length > 0) {
            const index = digits.indexOf(mod1[0]);
            digits.splice(index, 1);
        } else {
            if (mod2.length >= 2) {
                const index1 = digits.indexOf(mod2[0]);
                digits.splice(index1, 1);
                const index2 = digits.indexOf(mod2[1]);
                digits.splice(index2, 1);
            }
        }
    } else {
        if (mod2.length > 0) {
            const index = digits.indexOf(mod2[0]);
            digits.splice(index, 1);
        } else {
            if (mod1.length >= 2) {
                const index1 = digits.indexOf(mod1[0]);
                digits.splice(index1, 1);
                const index2 = digits.indexOf(mod1[1]);
                digits.splice(index2, 1);
            }
        }
    }
    while (digits.length > 0 && digits[0] === 0) {
        digits.shift();
    }
    return digits.length === 0 ? "0" : digits.join("");
}