function maxNumberOfSubstrings(s) {
    const count = {};
    for (let c of s) {
        count[c] = (count[c] || 0) + 1;
    }
    const result = [];
    const seen = new Set();
    let maxCount = 0;
    for (let i = 0; i < s.length; i++) {
        if (seen.has(s[i])) continue;
        let freq = count[s[i]];
        let left = i;
        let right = i;
        while (right < s.length) {
            if (count[s[right]] < freq) {
                break;
            }
            if (count[s[right]] > freq) {
                freq = count[s[right]];
            }
            right++;
        }
        if (right - left > maxCount) {
            maxCount = right - left;
            result.length = 0;
            result.push(s.substring(left, right));
        } else if (right - left === maxCount) {
            result.push(s.substring(left, right));
        }
        seen.add(s[i]);
    }
    return result.length;
}