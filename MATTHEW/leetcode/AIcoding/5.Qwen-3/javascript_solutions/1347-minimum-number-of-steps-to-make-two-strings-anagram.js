function minSteps(s, t) {
    const count = {};
    for (let char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    let steps = 0;
    for (let char of t) {
        if (count[char] > 0) {
            count[char]--;
        } else {
            steps++;
        }
    }
    return steps;
}