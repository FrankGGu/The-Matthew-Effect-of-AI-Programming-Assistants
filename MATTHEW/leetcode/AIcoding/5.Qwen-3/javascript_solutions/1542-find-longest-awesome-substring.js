function longestAwesome(s) {
    const map = new Map();
    map.set(0, -1);
    let max = 0;
    let state = 0;
    for (let i = 0; i < s.length; i++) {
        const digit = s[i] - '0';
        state ^= (1 << digit);
        if (map.has(state)) {
            max = Math.max(max, i - map.get(state));
        } else {
            map.set(state, i);
        }
        for (let j = 0; j < 10; j++) {
            const temp = state ^ (1 << j);
            if (map.has(temp)) {
                max = Math.max(max, i - map.get(temp));
            }
        }
    }
    return max;
}