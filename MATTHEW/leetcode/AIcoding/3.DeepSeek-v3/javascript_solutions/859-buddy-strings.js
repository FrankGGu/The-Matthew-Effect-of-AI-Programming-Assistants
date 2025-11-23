var buddyStrings = function(s, goal) {
    if (s.length !== goal.length) return false;

    if (s === goal) {
        const seen = new Set();
        for (const char of s) {
            if (seen.has(char)) {
                return true;
            }
            seen.add(char);
        }
        return false;
    } else {
        const pairs = [];
        for (let i = 0; i < s.length; i++) {
            if (s[i] !== goal[i]) {
                pairs.push([s[i], goal[i]]);
                if (pairs.length > 2) return false;
            }
        }
        return pairs.length === 2 && pairs[0][0] === pairs[1][1] && pairs[0][1] === pairs[1][0];
    }
};