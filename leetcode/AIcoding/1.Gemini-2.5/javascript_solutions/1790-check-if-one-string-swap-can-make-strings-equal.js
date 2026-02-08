var areAlmostEqual = function(s1, s2) {
    if (s1 === s2) {
        return true;
    }

    const diffIndices = [];
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            diffIndices.push(i);
        }
    }

    if (diffIndices.length === 2) {
        const i = diffIndices[0];
        const j = diffIndices[1];
        return s1[i] === s2[j] && s1[j] === s2[i];
    }

    return false;
};