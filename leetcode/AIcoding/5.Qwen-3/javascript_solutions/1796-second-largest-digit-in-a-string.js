function secondLargest(s) {
    let max = -1;
    let secondMax = -1;
    for (let c of s) {
        if (c >= '0' && c <= '9') {
            let num = parseInt(c);
            if (num > max) {
                secondMax = max;
                max = num;
            } else if (num < max && num > secondMax) {
                secondMax = num;
            }
        }
    }
    return secondMax;
}