function numberOfDifferentIntegers(s) {
    const set = new Set();
    let num = '';
    for (let i = 0; i < s.length; i++) {
        if (/[0-9]/.test(s[i])) {
            num += s[i];
        } else {
            if (num !== '') {
                set.add(num);
                num = '';
            }
        }
    }
    if (num !== '') {
        set.add(num);
    }
    return set.size;
}