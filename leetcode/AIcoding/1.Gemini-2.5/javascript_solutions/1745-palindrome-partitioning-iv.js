var checkPartitioning = function(s) {
    const n = s.length;

    const isPalindrome = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            isPalindrome[i][i + 1] = true;
        }
    }

    for (let len = 3; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            if (s[i] === s[j] && isPalindrome[i + 1][j - 1]) {
                isPalindrome[i][j] = true;
            }
        }
    }

    for (let i = 0; i < n - 2; i++) {
        if (isPalindrome[0][i]) {
            for (let j = i + 1; j < n - 1; j++) {
                if (isPalindrome[i + 1][j]) {
                    if (isPalindrome[j + 1][n - 1]) {
                        return true;
                    }
                }
            }
        }
    }

    return false;
};