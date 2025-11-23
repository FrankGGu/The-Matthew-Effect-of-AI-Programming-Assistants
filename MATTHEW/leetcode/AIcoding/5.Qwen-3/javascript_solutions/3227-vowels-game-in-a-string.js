function canAliceWin(s) {
    let vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    for (let c of s) {
        if (vowels.has(c)) {
            count++;
        }
    }
    return count % 2 === 1;
}