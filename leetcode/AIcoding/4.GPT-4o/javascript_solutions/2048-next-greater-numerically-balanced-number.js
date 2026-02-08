var nextGreaterBalanced = function(n) {
    const digits = String(n).split('').map(Number);
    const len = digits.length;

    for (let i = len - 1; i > 0; i--) {
        if (digits[i] > digits[i - 1]) {
            let j = len - 1;
            while (digits[j] <= digits[i - 1]) {
                j--;
            }
            [digits[i - 1], digits[j]] = [digits[j], digits[i - 1]];
            const nextPart = digits.slice(i).sort((a, b) => a - b);
            const candidate = Number([...digits.slice(0, i), ...nextPart].join(''));
            if (isBalanced(candidate)) {
                return candidate;
            }
            break;
        }
    }
    return -1;
};

function isBalanced(num) {
    const digits = String(num).split('').map(Number);
    const half = digits.length / 2;
    const count = {};
    for (let d of digits) {
        count[d] = (count[d] || 0) + 1;
    }
    return Object.values(count).every(c => c <= half);
}