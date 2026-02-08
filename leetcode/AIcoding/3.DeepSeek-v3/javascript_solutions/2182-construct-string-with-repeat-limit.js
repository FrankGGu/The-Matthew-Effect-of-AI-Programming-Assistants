var repeatLimitedString = function(s, repeatLimit) {
    const freq = {};
    for (const c of s) {
        freq[c] = (freq[c] || 0) + 1;
    }
    const chars = Object.keys(freq).sort((a, b) => b.localeCompare(a));
    let res = [];
    let i = 0;
    while (i < chars.length) {
        const c = chars[i];
        if (freq[c] === 0) {
            i++;
            continue;
        }
        let use = Math.min(freq[c], repeatLimit);
        res.push(c.repeat(use));
        freq[c] -= use;
        if (freq[c] > 0) {
            let found = false;
            for (let j = i + 1; j < chars.length; j++) {
                if (freq[chars[j]] > 0) {
                    res.push(chars[j]);
                    freq[chars[j]]--;
                    found = true;
                    break;
                }
            }
            if (!found) {
                break;
            }
        }
    }
    return res.join('');
};