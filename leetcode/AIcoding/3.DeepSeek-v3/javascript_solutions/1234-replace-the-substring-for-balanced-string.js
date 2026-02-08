var balancedString = function(s) {
    const count = { Q: 0, W: 0, E: 0, R: 0 };
    for (const c of s) {
        count[c]++;
    }
    const n = s.length;
    const target = n / 4;
    let left = 0;
    let minLen = n;

    for (let right = 0; right < n; right++) {
        count[s[right]]--;

        while (left < n && 
               count['Q'] <= target && 
               count['W'] <= target && 
               count['E'] <= target && 
               count['R'] <= target) {
            minLen = Math.min(minLen, right - left + 1);
            count[s[left]]++;
            left++;
        }
    }

    return minLen;
};