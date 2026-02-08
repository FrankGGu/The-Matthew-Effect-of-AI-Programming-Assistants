var minSteps = function(s, t) {
    const count = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        count[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        count[t.charCodeAt(i) - 'a'.charCodeAt(0)]--;
    }
    let steps = 0;
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            steps += count[i];
        }
    }
    return steps;
};