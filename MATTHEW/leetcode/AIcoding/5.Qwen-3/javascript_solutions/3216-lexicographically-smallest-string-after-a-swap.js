function lexSmallestString(s) {
    let sArr = s.split('');
    let n = sArr.length;

    for (let i = 0; i < n - 1; i++) {
        if (sArr[i] > sArr[i + 1]) {
            [sArr[i], sArr[i + 1]] = [sArr[i + 1], sArr[i]];
            break;
        }
    }

    return sArr.join('');
}