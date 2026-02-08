var countTime = function(time) {
    const [h1, h2, , m1, m2] = time.split('');
    let countH = 0;
    for (let h = 0; h < 24; h++) {
        const [a, b] = String(h).padStart(2, '0').split('');
        if ((h1 === '?' || h1 === a) && (h2 === '?' || h2 === b)) {
            countH++;
        }
    }
    let countM = 0;
    for (let m = 0; m < 60; m++) {
        const [a, b] = String(m).padStart(2, '0').split('');
        if ((m1 === '?' || m1 === a) && (m2 === '?' || m2 === b)) {
            countM++;
        }
    }
    return countH * countM;
};