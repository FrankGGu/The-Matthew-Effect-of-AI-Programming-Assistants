var checkIfCanBreak = function(s1, s2) {
    const n = s1.length;
    const arr1 = s1.split('').sort();
    const arr2 = s2.split('').sort();

    let canBreak1 = true;
    let canBreak2 = true;

    for (let i = 0; i < n; i++) {
        if (arr1[i].charCodeAt(0) < arr2[i].charCodeAt(0)) {
            canBreak1 = false;
        }
        if (arr2[i].charCodeAt(0) < arr1[i].charCodeAt(0)) {
            canBreak2 = false;
        }
    }

    return canBreak1 || canBreak2;
};