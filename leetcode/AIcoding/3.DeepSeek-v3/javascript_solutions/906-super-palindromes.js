var superpalindromesInRange = function(left, right) {
    const L = BigInt(left);
    const R = BigInt(right);
    let count = 0;

    const isPalindrome = (s) => {
        s = s.toString();
        let l = 0, r = s.length - 1;
        while (l < r) {
            if (s[l] !== s[r]) return false;
            l++;
            r--;
        }
        return true;
    };

    for (let k = 1; k < 100000; k++) {
        const s = k.toString();
        const rs = s.split('').reverse().join('');
        const num1 = BigInt(s + rs);
        const square1 = num1 * num1;
        if (square1 > R) break;
        if (square1 >= L && isPalindrome(square1)) {
            count++;
        }
    }

    for (let k = 1; k < 100000; k++) {
        const s = k.toString();
        const rs = s.slice(0, -1).split('').reverse().join('');
        const num2 = BigInt(s + rs);
        const square2 = num2 * num2;
        if (square2 > R) break;
        if (square2 >= L && isPalindrome(square2)) {
            count++;
        }
    }

    return count;
};