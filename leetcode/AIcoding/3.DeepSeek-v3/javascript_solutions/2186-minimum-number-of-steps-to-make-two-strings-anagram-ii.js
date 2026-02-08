var minSteps = function(s, t) {
    const count = new Array(26).fill(0);
    for (const char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    for (const char of t) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]--;
    }
    let steps = 0;
    for (const num of count) {
        steps += Math.abs(num);
    }
    return steps;
};