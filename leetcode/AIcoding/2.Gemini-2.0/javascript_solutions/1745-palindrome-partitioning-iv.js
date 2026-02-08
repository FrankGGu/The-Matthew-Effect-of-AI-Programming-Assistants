var checkPartitioning = function(s) {
    const n = s.length;
    const isPalindrome = Array(n).fill(null).map(() => Array(n).fill(false));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i; j < n; j++) {
            if (s[i] === s[j] && (j - i <= 2 || isPalindrome[i + 1][j - 1])) {
                isPalindrome[i][j] = true;
            }
        }
    }

    for (let i = 1; i < n - 1; i++) {
        if (isPalindrome[0][i - 1]) {
            for (let j = i + 1; j < n; j++) {
                if (isPalindrome[i][j - 1] && isPalindrome[j][n - 1]) {
                    return true;
                }
            }
        }
    }

    return false;
};