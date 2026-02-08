var largestMultipleOfThree = function(digits) {
    digits.sort((a, b) => b - a);
    let sum = digits.reduce((acc, curr) => acc + curr, 0);
    let n = digits.length;

    if (sum % 3 === 1) {
        let found = false;
        for (let i = n - 1; i >= 0; i--) {
            if (digits[i] % 3 === 1) {
                digits.splice(i, 1);
                found = true;
                break;
            }
        }
        if (!found) {
            let count = 0;
            for (let i = n - 1; i >= 0; i--) {
                if (digits[i] % 3 === 2) {
                    digits.splice(i, 1);
                    count++;
                }
                if (count === 2) break;
            }
            if (count < 2) return "0";
        }
    } else if (sum % 3 === 2) {
        let found = false;
        for (let i = n - 1; i >= 0; i--) {
            if (digits[i] % 3 === 2) {
                digits.splice(i, 1);
                found = true;
                break;
            }
        }
        if (!found) {
            let count = 0;
            for (let i = n - 1; i >= 0; i--) {
                if (digits[i] % 3 === 1) {
                    digits.splice(i, 1);
                    count++;
                }
                if (count === 2) break;
            }
            if (count < 2) return "0";
        }
    }

    if (digits.length === 0) return "0";
    if (digits[0] === 0) return "0";

    return digits.join('');
};