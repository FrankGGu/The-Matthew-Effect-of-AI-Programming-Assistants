var checkStrings = function(s1, s2) {
    const n = s1.length;

    const s1_even_chars = [];
    const s1_odd_chars = [];
    const s2_even_chars = [];
    const s2_odd_chars = [];

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            s1_even_chars.push(s1[i]);
            s2_even_chars.push(s2[i]);
        } else {
            s1_odd_chars.push(s1[i]);
            s2_odd_chars.push(s2[i]);
        }
    }

    s1_even_chars.sort();
    s1_odd_chars.sort();
    s2_even_chars.sort();
    s2_odd_chars.sort();

    return s1_even_chars.join('') === s2_even_chars.join('') &&
           s1_odd_chars.join('') === s2_odd_chars.join('');
};