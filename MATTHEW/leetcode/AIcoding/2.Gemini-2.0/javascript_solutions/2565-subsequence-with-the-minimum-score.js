var minimumScore = function(s, t) {
    const n = s.length;
    const m = t.length;
    const prefix = new Array(m + 1).fill(0);
    const suffix = new Array(m + 1).fill(0);

    let j = 0;
    for (let i = 0; i < m; i++) {
        prefix[i + 1] = prefix[i];
        if (j < n && s[j] === t[i]) {
            prefix[i + 1]++;
            j++;
        }
    }

    j = n - 1;
    for (let i = m - 1; i >= 0; i--) {
        suffix[i] = suffix[i + 1];
        if (j >= 0 && s[j] === t[i]) {
            suffix[i]++;
            j--;
        }
    }

    let ans = m;
    for (let i = 0; i <= m; i++) {
        let left = prefix[i];
        let right = 0;
        let low = i, high = m;
        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (left + suffix[mid] >= m) {
                right = m - left;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans = Math.min(ans, right);
    }

    return ans;
};