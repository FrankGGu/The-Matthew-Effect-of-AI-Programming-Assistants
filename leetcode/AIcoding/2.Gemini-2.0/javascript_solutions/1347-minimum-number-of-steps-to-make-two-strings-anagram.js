var minSteps = function(s, t) {
    const sCount = new Array(26).fill(0);
    const tCount = new Array(26).fill(0);

    for (let char of s) {
        sCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let char of t) {
        tCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let steps = 0;
    for (let i = 0; i < 26; i++) {
        steps += Math.abs(sCount[i] - tCount[i]);
    }

    return steps / 2;
};