var checkIfCanBreak = function(s1, s2) {
    const count1 = Array(26).fill(0);
    const count2 = Array(26).fill(0);

    for (let c of s1) count1[c.charCodeAt() - 'a'.charCodeAt()]++;
    for (let c of s2) count2[c.charCodeAt() - 'a'.charCodeAt()]++;

    const canBreak = (countA, countB) => {
        let sumA = 0, sumB = 0;
        for (let i = 0; i < 26; i++) {
            sumA += countA[i];
            sumB += countB[i];
            if (sumA < sumB) return false;
        }
        return true;
    };

    return canBreak(count1, count2) || canBreak(count2, count1);
};