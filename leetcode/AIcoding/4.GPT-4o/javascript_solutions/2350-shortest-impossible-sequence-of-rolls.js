function shortestSequence(rolls, k) {
    const seen = new Set();
    for (let i = 0; i < rolls.length; i++) {
        seen.add(rolls[i]);
        if (seen.size === k) {
            return i + 1;
        }
    }
    return rolls.length + 1;
}