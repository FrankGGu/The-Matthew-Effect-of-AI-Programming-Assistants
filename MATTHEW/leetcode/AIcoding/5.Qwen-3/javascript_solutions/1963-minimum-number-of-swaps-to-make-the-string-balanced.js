function minSwaps(s) {
    let open = 0;
    let close = 0;
    for (let c of s) {
        if (c === '[') {
            open++;
        } else {
            close++;
            if (close > open) {
                open++;
                close--;
            }
        }
    }
    return Math.ceil((open - close) / 2);
}