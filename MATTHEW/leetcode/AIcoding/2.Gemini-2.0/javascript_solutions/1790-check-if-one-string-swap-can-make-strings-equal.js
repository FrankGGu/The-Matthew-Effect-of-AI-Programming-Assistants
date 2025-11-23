var areAlmostEqual = function(s1, s2) {
    if (s1 === s2) return true;
    let diff = [];
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            diff.push(i);
        }
    }
    if (diff.length === 2) {
        let i = diff[0];
        let j = diff[1];
        return s1[i] === s2[j] && s1[j] === s2[i];
    }
    return false;
};