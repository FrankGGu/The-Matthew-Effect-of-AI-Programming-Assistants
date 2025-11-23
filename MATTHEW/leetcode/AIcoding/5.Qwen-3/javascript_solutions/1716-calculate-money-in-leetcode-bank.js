function totalMoney(n) {
    let total = 0;
    let base = 1;
    while (n > 0) {
        for (let i = 0; i < 7 && n > 0; i++) {
            total += base + i;
            n--;
        }
        base += 7;
    }
    return total;
}