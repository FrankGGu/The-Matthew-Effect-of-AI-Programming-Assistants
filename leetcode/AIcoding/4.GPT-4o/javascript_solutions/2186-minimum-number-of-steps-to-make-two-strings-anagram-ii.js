var minSteps = function(s, t) {
    const countS = new Array(26).fill(0);
    const countT = new Array(26).fill(0);

    for (let char of s) {
        countS[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let char of t) {
        countT[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let steps = 0;
    for (let i = 0; i < 26; i++) {
        steps += Math.abs(countS[i] - countT[i]);
    }

    return steps;
};