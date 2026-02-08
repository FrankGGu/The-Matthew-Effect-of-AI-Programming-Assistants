function numGoodWays(s) {
    let left = new Set();
    let right = new Set();
    let count = 0;

    for (let i = 0; i < s.length; i++) {
        left.add(s[i]);
        if (i < s.length - 1) {
            for (let j = i + 1; j < s.length; j++) {
                right.add(s[j]);
            }
            if (left.size === right.size) {
                count++;
            }
            right.clear();
        }
    }

    return count;
}