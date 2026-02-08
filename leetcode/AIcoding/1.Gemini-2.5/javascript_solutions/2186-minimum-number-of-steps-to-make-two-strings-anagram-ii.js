var minSteps = function(s, t) {
    const freqS = new Array(26).fill(0);
    const freqT = new Array(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        freqS[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < t.length; i++) {
        freqT[t.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let steps = 0;
    for (let i = 0; i < 26; i++) {
        steps += Math.abs(freqS[i] - freqT[i]);
    }

    return steps;
};