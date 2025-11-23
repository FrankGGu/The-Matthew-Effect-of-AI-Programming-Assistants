var countSubstrings = function(s) {
    let count = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        expandAroundCenter(i, i);
        expandAroundCenter(i, i + 1);
    }

    function expandAroundCenter(left, right) {
        while (left >= 0 && right < n && s[left] === s[right]) {
            count++;
            left--;
            right++;
        }
    }

    return count;
};