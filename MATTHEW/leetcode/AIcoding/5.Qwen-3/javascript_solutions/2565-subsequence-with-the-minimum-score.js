function minWindow(s, t) {
    if (t.length === 0 || s.length < t.length) return "";
    const need = new Map();
    for (const c of t) {
        need.set(c, (need.get(c) || 0) + 1);
    }
    let needLen = t.length;
    let left = 0, right = 0;
    let resLeft = 0, resRight = s.length;
    while (right < s.length) {
        const c = s[right];
        if (need.has(c)) {
            need.set(c, need.get(c) - 1);
            if (need.get(c) === 0) {
                needLen--;
            }
        }
        right++;
        while (needLen === 0) {
            if (right - left < resRight - resLeft) {
                resLeft = left;
                resRight = right;
            }
            const leftC = s[left];
            if (need.has(leftC)) {
                need.set(leftC, need.get(leftC) + 1);
                if (need.get(leftC) === 1) {
                    needLen++;
                }
            }
            left++;
        }
    }
    return resRight - resLeft === s.length ? "" : s.substring(resLeft, resRight);
}