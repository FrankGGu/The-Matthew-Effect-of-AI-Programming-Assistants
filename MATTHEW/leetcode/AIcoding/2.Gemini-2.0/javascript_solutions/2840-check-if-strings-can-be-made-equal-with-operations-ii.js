var checkStrings = function(s1, s2) {
    if (s1.length !== s2.length) return false;
    const odd1 = [];
    const even1 = [];
    const odd2 = [];
    const even2 = [];

    for (let i = 0; i < s1.length; i++) {
        if (i % 2 === 0) {
            even1.push(s1[i]);
            even2.push(s2[i]);
        } else {
            odd1.push(s1[i]);
            odd2.push(s2[i]);
        }
    }

    odd1.sort();
    odd2.sort();
    even1.sort();
    even2.sort();

    return odd1.join('') === odd2.join('') && even1.join('') === even2.join('');
};