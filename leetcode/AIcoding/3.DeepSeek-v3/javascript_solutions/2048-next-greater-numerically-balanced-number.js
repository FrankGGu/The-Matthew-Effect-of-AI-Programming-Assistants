var nextBeautifulNumber = function(n) {
    function isBalanced(num) {
        const str = num.toString();
        const count = {};
        for (const c of str) {
            count[c] = (count[c] || 0) + 1;
        }
        for (const c in count) {
            if (parseInt(c) !== count[c]) {
                return false;
            }
        }
        return true;
    }

    let candidate = n + 1;
    while (true) {
        if (isBalanced(candidate)) {
            return candidate;
        }
        candidate++;
    }
};