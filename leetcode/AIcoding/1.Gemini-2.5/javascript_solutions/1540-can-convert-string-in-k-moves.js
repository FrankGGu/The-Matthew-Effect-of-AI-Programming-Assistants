var canConvertString = function(s, t, k) {
    if (s.length !== t.length) {
        return false;
    }

    const shiftCounts = new Array(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        const charS = s.charCodeAt(i);
        const charT = t.charCodeAt(i);

        let diff = (charT - charS + 26) % 26;

        if (diff === 0) {
            continue;
        }

        const currentMoves = diff + shiftCounts[diff] * 26;

        if (currentMoves > k) {
            return false;
        }

        shiftCounts[diff]++;
    }

    return true;
};