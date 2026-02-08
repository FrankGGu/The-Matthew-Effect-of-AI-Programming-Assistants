var checkIfCanBreak = function(s1, s2) {
    const sortedS1 = s1.split('').sort();
    const sortedS2 = s2.split('').sort();
    let canBreak1 = true;
    let canBreak2 = true;

    for (let i = 0; i < sortedS1.length; i++) {
        if (sortedS1[i] < sortedS2[i]) {
            canBreak1 = false;
        }
        if (sortedS2[i] < sortedS1[i]) {
            canBreak2 = false;
        }
        if (!canBreak1 && !canBreak2) {
            return false;
        }
    }

    return canBreak1 || canBreak2;
};