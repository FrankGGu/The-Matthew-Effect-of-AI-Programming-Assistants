function longestString(a, b) {
    let res = 0;
    while (a > 0 && b > 0) {
        if (a > b) {
            res += b * 2;
            a -= b;
        } else {
            res += a * 2;
            b -= a;
        }
    }
    return res;
}