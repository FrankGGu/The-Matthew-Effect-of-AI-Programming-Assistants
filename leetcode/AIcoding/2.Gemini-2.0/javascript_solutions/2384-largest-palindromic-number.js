var largestPalindromic = function(num) {
    const counts = new Array(10).fill(0);
    for (const digit of num) {
        counts[parseInt(digit)]++;
    }

    let left = "";
    for (let i = 9; i >= 0; i--) {
        const count = counts[i];
        if (count >= 2) {
            const pairs = Math.floor(count / 2);
            left += String(i).repeat(pairs);
            counts[i] -= pairs * 2;
        }
    }

    if (left.length === 0) {
        for (let i = 9; i >= 0; i--) {
            if (counts[i] > 0) {
                return String(i);
            }
        }
        return "0";
    }

    if (left[0] === '0') {
        return "0";
    }

    let middle = "";
    for (let i = 9; i >= 0; i--) {
        if (counts[i] > 0) {
            middle = String(i);
            break;
        }
    }

    const right = left.split("").reverse().join("");
    return left + middle + right;
};