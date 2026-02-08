function checkPartitioning(s) {
    const n = s.length;
    const isPalindrome = Array.from({ length: n }, () => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        isPalindrome[i][i + 1] = (s[i] === s[i + 1]);
    }

    for (let length = 3; length <= n; length++) {
        for (let start = 0; start <= n - length; start++) {
            const end = start + length - 1;
            isPalindrome[start][end] = (s[start] === s[end]) && isPalindrome[start + 1][end - 1];
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

    return isPalindrome[0][n - 1];
}