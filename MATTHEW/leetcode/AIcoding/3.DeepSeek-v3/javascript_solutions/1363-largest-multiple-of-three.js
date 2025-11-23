var largestMultipleOfThree = function(digits) {
    let sum = digits.reduce((a, b) => a + b, 0);
    digits.sort((a, b) => b - a);

    if (sum % 3 === 1) {
        let found = false;
        for (let i = digits.length - 1; i >= 0; i--) {
            if (digits[i] % 3 === 1) {
                digits.splice(i, 1);
                found = true;
                break;
            }
        }
        if (!found) {
            let count = 0;
            for (let i = digits.length - 1; i >= 0; i--) {
                if (digits[i] % 3 === 2) {
                    digits.splice(i, 1);
                    count++;
                    if (count === 2) break;
                }
            }
        }
    } else if (sum % 3 === 2) {
        let found = false;
        for (let i = digits.length - 1; i >= 0; i--) {
            if (digits[i] % 3 === 2) {
                digits.splice(i, 1);
                found = true;
                break;
            }
        }
        if (!found) {
            let count = 0;
            for (let i = digits.length - 1; i >= 0; i--) {
                if (digits[i] % 3 === 1) {
                    digits.splice(i, 1);
                    count++;
                    if (count === 2) break;
                }
            }
        }
    }

    if (digits.length === 0) return "";
    if (digits[0] === 0) return "0";
    return digits.join("");
};