var nearestPalindromic = function(n) {
    const len = n.length;
    if (len === 1) return String(Number(n) - 1);

    const candidates = [String(10 ** (len - 1) - 1), String(10 ** len + 1)];
    const prefix = n.substring(0, Math.floor((len + 1) / 2));
    const prefixes = [Number(prefix) - 1, Number(prefix), Number(prefix) + 1];

    for (const p of prefixes) {
        const prefixStr = String(p);
        let candidate = prefixStr;
        let suffix = prefixStr.split('').reverse().join('');
        if (len % 2 === 1) {
            candidate += suffix.substring(1);
        } else {
            candidate += suffix;
        }
        candidates.push(candidate);
    }

    let ans = "";
    let diff = Infinity;
    const num = Number(n);

    for (const candidate of candidates) {
        if (candidate === n) continue;
        const candidateNum = Number(candidate);
        const currentDiff = Math.abs(candidateNum - num);

        if (currentDiff < diff) {
            diff = currentDiff;
            ans = candidate;
        } else if (currentDiff === diff) {
            if (Number(candidate) < Number(ans)) {
                ans = candidate;
            }
        }
    }

    return ans;
};