var splitMessage = function(message, limit) {
    const n = message.length;
    let parts = -1;

    for (let k = 1; k <= n; ++k) {
        const suffixLen = 3 + String(k).length * 2;
        if (suffixLen >= limit) {
            continue;
        }
        let total = 0;
        for (let i = 1; i <= k; ++i) {
            const partSuffixLen = 3 + String(i).length + String(k).length;
            const partLen = limit - partSuffixLen;
            if (partLen <= 0) {
                total = -1;
                break;
            }
            total += partLen;
        }
        if (total >= n) {
            parts = k;
            break;
        }
    }

    if (parts === -1) {
        return [];
    }

    const res = [];
    let pos = 0;
    for (let i = 1; i <= parts; ++i) {
        const partSuffixLen = 3 + String(i).length + String(parts).length;
        const partLen = limit - partSuffixLen;
        const end = Math.min(pos + partLen, n);
        const chunk = message.slice(pos, end);
        res.push(`${chunk}<${i}/${parts}>`);
        pos = end;
    }

    return res;
};