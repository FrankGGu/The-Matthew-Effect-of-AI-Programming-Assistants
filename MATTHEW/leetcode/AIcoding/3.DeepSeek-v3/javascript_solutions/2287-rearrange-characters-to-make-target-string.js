var rearrangeCharacters = function(s, target) {
    const countS = new Array(26).fill(0);
    const countT = new Array(26).fill(0);

    for (const c of s) {
        countS[c.charCodeAt() - 'a'.charCodeAt()]++;
    }

    for (const c of target) {
        countT[c.charCodeAt() - 'a'.charCodeAt()]++;
    }

    let minCopies = Infinity;

    for (let i = 0; i < 26; i++) {
        if (countT[i] > 0) {
            const copies = Math.floor(countS[i] / countT[i]);
            if (copies < minCopies) {
                minCopies = copies;
            }
        }
    }

    return minCopies === Infinity ? 0 : minCopies;
};