function numJewelsInStones(J, S) {
    let jewelSet = new Set(J);
    let count = 0;
    for (let stone of S) {
        if (jewelSet.has(stone)) {
            count++;
        }
    }
    return count;
}