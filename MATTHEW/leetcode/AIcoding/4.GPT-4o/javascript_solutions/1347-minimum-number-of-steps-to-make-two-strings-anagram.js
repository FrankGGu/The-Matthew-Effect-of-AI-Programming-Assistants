var minSteps = function(s, t) {
    const countS = Array(26).fill(0);
    const countT = Array(26).fill(0);

    for (const char of s) {
        countS[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (const char of t) {
        countT[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let steps = 0;
    for (let i = 0; i < 26; i++) {
        steps += Math.max(0, countS[i] - countT[i]);
    }

    return steps;
};