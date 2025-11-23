function nearestPalindromes(n) {
    const len = n.length;
    const candidates = new Set();

    candidates.add(Math.pow(10, len - 1) - 1);
    candidates.add(Math.pow(10, len) + 1);

    const prefix = parseInt(n.substring(0, (len + 1) / 2));
    for (let i of [prefix - 1, prefix, prefix + 1]) {
        const left = i.toString();
        let right = left.slice(0, len % 2).split('').reverse().join('');
        candidates.add(parseInt(left + right));
    }

    let minDiff = Infinity;
    let result = 0;
    for (let candidate of candidates) {
        if (candidate === parseInt(n)) continue;
        const diff = Math.abs(candidate - parseInt(n));
        if (diff < minDiff || (diff === minDiff && candidate < result)) {
            minDiff = diff;
            result = candidate;
        }
    }

    return result.toString();
}