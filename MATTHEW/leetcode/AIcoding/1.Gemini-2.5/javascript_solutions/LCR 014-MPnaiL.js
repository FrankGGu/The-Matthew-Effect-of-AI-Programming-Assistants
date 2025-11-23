var permutation = function(s) {
    const result = [];
    const chars = s.split('').sort();
    const used = new Array(chars.length).fill(false);
    const currentPermutation = [];

    function backtrack() {
        if (currentPermutation.length === chars.length) {
            result.push(currentPermutation.join(''));
            return;
        }

        for (let i = 0; i < chars.length; i++) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && chars[i] === chars[i - 1] && !used[i - 1]) {
                continue;
            }

            used[i] = true;
            currentPermutation.push(chars[i]);
            backtrack();
            currentPermutation.pop();
            used[i] = false;
        }
    }

    backtrack();
    return result;
};