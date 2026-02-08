var nearestPalindromic = function(n) {
    const num = parseInt(n);
    if (num === 0) return "1";
    if (num <= 10) return (num - 1).toString();
    if (num === 11) return "9";

    const candidates = new Set();
    candidates.add(Math.pow(10, n.length) + 1);
    candidates.add(Math.pow(10, n.length - 1) - 1);

    const prefix = parseInt(n.substring(0, Math.floor((n.length + 1) / 2));
    for (let i = -1; i <= 1; i++) {
        const p = (prefix + i).toString();
        const candidate = p + p.substring(0, p.length - (n.length % 2)).split('').reverse().join('');
        candidates.add(parseInt(candidate));
    }

    candidates.delete(num);

    let minDiff = Infinity, result = -1;
    candidates.forEach(candidate => {
        const diff = Math.abs(candidate - num);
        if (diff < minDiff || (diff === minDiff && candidate < result)) {
            minDiff = diff;
            result = candidate;
        }
    });

    return result.toString();
};