function diStringMatch(S) {
    const n = S.length;
    const result = new Array(n + 1);
    let low = 0;
    let high = n;

    for (let i = 0; i < n; i++) {
        if (S[i] === 'I') {
            result[i] = low++;
        } else {
            result[i] = high--;
        }
    }
    result[n] = low; // or result[n] = high;

    return result;
}