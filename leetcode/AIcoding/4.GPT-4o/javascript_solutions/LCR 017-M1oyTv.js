function minWindow(s, t) {
    const need = {};
    const window = {};
    for (let char of t) {
        need[char] = (need[char] || 0) + 1;
    }

    let left = 0, right = 0, valid = 0;
    let start = 0, minLength = Infinity;

    while (right < s.length) {
        const c = s[right];
        right++;
        if (need[c]) {
            window[c] = (window[c] || 0) + 1;
            if (window[c] === need[c]) {
                valid++;
            }
        }

        while (valid === Object.keys(need).length) {
            if (right - left < minLength) {
                start = left;
                minLength = right - left;
            }
            const d = s[left];
            left++;
            if (need[d]) {
                if (window[d] === need[d]) {
                    valid--;
                }
                window[d]--;
            }
        }
    }

    return minLength === Infinity ? "" : s.substring(start, start + minLength);
}