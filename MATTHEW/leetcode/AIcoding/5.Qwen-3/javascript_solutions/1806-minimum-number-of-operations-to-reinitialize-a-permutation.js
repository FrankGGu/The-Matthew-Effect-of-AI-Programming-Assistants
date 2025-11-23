function reinitializePermutation(n) {
    let res = 0;
    let pos = 1;
    while (pos !== 1 || res === 0) {
        if (pos < n / 2) {
            pos *= 2;
        } else {
            pos = 2 * (pos - n / 2);
        }
        res++;
    }
    return res;
}