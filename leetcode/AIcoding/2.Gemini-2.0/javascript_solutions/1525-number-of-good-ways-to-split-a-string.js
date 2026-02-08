var numSplits = function(s) {
    let n = s.length;
    let left = new Set();
    let right = new Map();
    for (let char of s) {
        right.set(char, (right.get(char) || 0) + 1);
    }

    let count = 0;
    for (let i = 0; i < n - 1; i++) {
        let char = s[i];
        left.add(char);
        right.set(char, right.get(char) - 1);
        if (right.get(char) === 0) {
            right.delete(char);
        }

        if (left.size === right.size) {
            count++;
        }
    }

    return count;
};