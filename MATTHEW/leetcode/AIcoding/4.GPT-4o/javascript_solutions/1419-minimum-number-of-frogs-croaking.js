function minNumberOfFrogs(croakOfFrogs) {
    const croakCount = { 'c': 0, 'r': 0, 'o': 0, 'a': 0, 'k': 0 };
    let frogs = 0, maxFrogs = 0;

    for (let char of croakOfFrogs) {
        croakCount[char]++;
        if (char === 'c') {
            frogs++;
            maxFrogs = Math.max(maxFrogs, frogs);
        } else if (char === 'r') {
            if (croakCount['c'] <= 0) return -1;
            croakCount['c']--;
        } else if (char === 'o') {
            if (croakCount['r'] <= 0) return -1;
            croakCount['r']--;
        } else if (char === 'a') {
            if (croakCount['o'] <= 0) return -1;
            croakCount['o']--;
        } else if (char === 'k') {
            if (croakCount['a'] <= 0) return -1;
            croakCount['a']--;
            frogs--;
        }
    }

    return frogs === 0 ? maxFrogs : -1;
}