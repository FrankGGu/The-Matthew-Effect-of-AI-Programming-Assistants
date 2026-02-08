function checkIfCanBreak(s1, s2) {
    const sortedS1 = s1.split('').sort();
    const sortedS2 = s2.split('').sort();

    let canBreak1 = true;
    let canBreak2 = true;

    for (let i = 0; i < s1.length; i++) {
        if (sortedS1[i] !== sortedS2[i]) {
            canBreak1 = canBreak1 && (sortedS1[i] > sortedS2[i]);
            canBreak2 = canBreak2 && (sortedS2[i] > sortedS1[i]);
        }
    }

    return canBreak1 || canBreak2;
}