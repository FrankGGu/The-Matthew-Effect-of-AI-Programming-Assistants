function numSpecial(s) {
    const rows = new Array(s.length).fill(0);
    const cols = new Array(s[0].length).fill(0);

    for (let i = 0; i < s.length; i++) {
        for (let j = 0; j < s[i].length; j++) {
            if (s[i][j] === '1') {
                rows[i]++;
                cols[j]++;
            }
        }
    }

    let count = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = 0; j < s[i].length; j++) {
            if (s[i][j] === '1' && rows[i] === 1 && cols[j] === 1) {
                count++;
            }
        }
    }

    return count;
}