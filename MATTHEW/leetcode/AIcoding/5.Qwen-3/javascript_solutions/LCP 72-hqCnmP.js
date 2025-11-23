function fillCups(amount) {
    let time = 0;
    while (amount[0] > 0 || amount[1] > 0) {
        if (amount[0] > 0) {
            amount[0]--;
        }
        if (amount[1] > 0) {
            amount[1]--;
        }
        time++;
    }
    return time;
}