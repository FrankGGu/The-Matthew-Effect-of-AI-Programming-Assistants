var countSpecialSubstrings = function(s) {
    let n = s.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        let left = i - 1;
        let right = i + 1;
        while (left >= 0 && right < n && s[left] === s[right]) {
            count++;
            left--;
            right++;
        }
    }
    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            let left = i - 1;
            let right = i + 2;
            while (left >= 0 && right < n && s[left] === s[right]) {
                count++;
                left--;
                right++;
            }
            count++;
        }
    }
    return count;
};