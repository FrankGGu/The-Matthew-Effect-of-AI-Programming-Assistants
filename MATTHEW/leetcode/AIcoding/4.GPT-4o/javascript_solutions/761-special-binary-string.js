function makeLargestSpecial(S) {
    let count = 0, last = 0;
    const res = [];

    for (let i = 0; i < S.length; i++) {
        count += S[i] === '1' ? 1 : -1;
        if (count === 0) {
            res.push('1' + makeLargestSpecial(S.slice(last + 1, i)) + '0');
            last = i + 1;
        }
    }

    return res.sort().reverse().join('');
}