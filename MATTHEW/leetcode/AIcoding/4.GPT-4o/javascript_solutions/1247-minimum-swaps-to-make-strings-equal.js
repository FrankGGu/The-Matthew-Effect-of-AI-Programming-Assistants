function minimumSwaps(s1, s2) {
    if (s1.length !== s2.length) return -1;

    let aCount = 0, bCount = 0;
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            if (s1[i] === 'a') aCount++;
            else bCount++;
        }
    }

    if ((aCount + bCount) % 2 !== 0) return -1;

    return Math.ceil(aCount / 2) + Math.ceil(bCount / 2);
}