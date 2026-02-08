var findAnagrams = function(s, p) {
    const result = [];
    const pCount = new Array(26).fill(0);
    const sCount = new Array(26).fill(0);

    for (let char of p) {
        pCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < s.length; i++) {
        sCount[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;

        if (i >= p.length) {
            sCount[s.charCodeAt(i - p.length) - 'a'.charCodeAt(0)]--;
        }

        if (sCount.join() === pCount.join()) {
            result.push(i - p.length + 1);
        }
    }

    return result;
};