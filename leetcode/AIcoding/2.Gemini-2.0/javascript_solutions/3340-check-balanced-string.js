var checkBalancedString = function(s) {
    const n = s.length;
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    const k = n / 4;
    let excess = 0;
    for (const char of ['Q', 'W', 'E', 'R']) {
        if ((count[char] || 0) > k) {
            excess += (count[char] || 0) - k;
        }
    }
    if (excess === 0) return 0;

    let left = 0;
    let minLength = n;
    const need = {};
    for (const char of ['Q', 'W', 'E', 'R']) {
        need[char] = Math.max(0, (count[char] || 0) - k);
    }

    let have = {};
    let required = 0;
    for (const char of ['Q', 'W', 'E', 'R']) {
        if (need[char] > 0) required++;
    }

    let fulfilled = 0;

    for (let right = 0; right < n; right++) {
        const char = s[right];
        have[char] = (have[char] || 0) + 1;

        if (need[char] > 0 && have[char] === need[char]) {
            fulfilled++;
        }

        while (fulfilled === required) {
            minLength = Math.min(minLength, right - left + 1);
            const leftChar = s[left];
            have[leftChar]--;
            if (need[leftChar] > 0 && have[leftChar] < need[leftChar]) {
                fulfilled--;
            }
            left++;
        }
    }

    return minLength;
};