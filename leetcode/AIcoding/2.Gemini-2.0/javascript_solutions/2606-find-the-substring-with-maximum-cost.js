var maxCost = function(s, chars, vals) {
    let costMap = new Map();
    for (let i = 0; i < chars.length; i++) {
        costMap.set(chars[i], vals[i]);
    }

    let maxSoFar = 0;
    let currentMax = 0;

    for (let i = 0; i < s.length; i++) {
        let char = s[i];
        let cost = costMap.get(char) || (char.charCodeAt(0) - 'a'.charCodeAt(0) + 1);
        currentMax += cost;
        if (currentMax < 0) {
            currentMax = 0;
        }
        maxSoFar = Math.max(maxSoFar, currentMax);
    }

    return maxSoFar;
};