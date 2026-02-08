var nextGreaterNumericallyBalancedNumber = function(n) {
    function isBalanced(num) {
        const s = String(num);
        const counts = new Array(10).fill(0);

        for (let i = 0; i < s.length; i++) {
            const digit = parseInt(s[i]);
            counts[digit]++;
        }

        for (let d = 0; d <= 9; d++) {
            if (counts[d] > 0 && counts[d] !== d) {
                return false;
            }
        }
        return true;
    }

    let currentNum = n + 1;
    while (true) {
        if (isBalanced(currentNum)) {
            return currentNum;
        }
        currentNum++;
    }
};