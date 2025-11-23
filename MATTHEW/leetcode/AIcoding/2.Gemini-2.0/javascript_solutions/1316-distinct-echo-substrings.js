var distinctEchoSubstrings = function(text) {
    const n = text.length;
    const seen = new Set();
    let count = 0;

    for (let len = 1; len <= Math.floor(n / 2); len++) {
        for (let i = 0; i <= n - 2 * len; i++) {
            const sub1 = text.substring(i, i + len);
            const sub2 = text.substring(i + len, i + 2 * len);

            if (sub1 === sub2) {
                const echoSub = sub1 + sub2;
                if (!seen.has(echoSub)) {
                    seen.add(echoSub);
                    count++;
                }
            }
        }
    }

    return count;
};