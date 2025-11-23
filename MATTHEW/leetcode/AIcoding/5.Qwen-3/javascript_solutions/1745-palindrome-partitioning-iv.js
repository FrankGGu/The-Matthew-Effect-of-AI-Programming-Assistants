function checkPartitioning(s) {
    const n = s.length;
    const isPalindrome = new Array(n).fill().map(() => new Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            isPalindrome[i][i + 1] = true;
        }
    }

    for (let length = 3; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            const j = i + length - 1;
            if (s[i] === s[j] && isPalindrome[i + 1][j - 1]) {
                isPalindrome[i][j] = true;
            }
        }
    }

    for (let i = 1; i < n - 1; i++) {
        if (isPalindrome[0][i] && isPalindrome[i + 1][n - 1]) {
            return true;
        }
    }

    return false;
}