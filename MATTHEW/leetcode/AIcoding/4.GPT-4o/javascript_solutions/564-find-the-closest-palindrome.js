var nearestPalindrome = function(n) {
    let num = BigInt(n);
    let len = n.length;
    let candidates = new Set();

    candidates.add((BigInt(10) ** BigInt(len - 1) - BigInt(1)).toString());
    candidates.add((BigInt(10) ** BigInt(len)).toString());

    let prefix = BigInt(n.slice(0, (len + 1) / 2));

    for (let i = -1; i <= 1; i++) {
        let newPrefix = (prefix + BigInt(i)).toString();
        let palindrome = newPrefix + newPrefix.split('').reverse().join('').slice(len % 2);
        candidates.add(palindrome);
    }

    candidates.delete(n);
    let closest = '';
    let minDiff = BigInt(Infinity);

    for (let candidate of candidates) {
        let candidateNum = BigInt(candidate);
        let diff = candidateNum - num;
        if (diff < 0) diff = -diff;
        if (diff < minDiff || (diff === minDiff && candidateNum < BigInt(closest))) {
            minDiff = diff;
            closest = candidate;
        }
    }

    return closest;
};