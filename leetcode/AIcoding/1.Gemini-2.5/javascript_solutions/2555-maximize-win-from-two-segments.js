var maximizeWin = function(prizes, k) {
    const n = prizes.length;
    if (n === 0) {
        return 0;
    }

    const left = new Array(n).fill(0);
    let j = 0;
    for (let i = 0; i < n; i++) {
        while (prizes[i] - prizes[j] > k) {
            j++;
        }
        let currentWindowPrizes = i - j + 1;
        left[i] = currentWindowPrizes;
        if (i > 0) {
            left[i] = Math.max(left[i], left[i - 1]);
        }
    }

    const right = new Array(n).fill(0);
    j = n - 1;
    for (let i = n - 1; i >= 0; i--) {
        while (prizes[j] - prizes[i] > k) {
            j--;
        }
        let currentWindowPrizes = j - i + 1;
        right[i] = currentWindowPrizes;
        if (i < n - 1) {
            right[i] = Math.max(right[i], right[i + 1]);
        }
    }

    let ans = 0;
    if (n > 0) {
        ans = left[n - 1];
    }

    for (let i = 0; i < n - 1; i++) {
        ans = Math.max(ans, left[i] + right[i + 1]);
    }

    return ans;
};