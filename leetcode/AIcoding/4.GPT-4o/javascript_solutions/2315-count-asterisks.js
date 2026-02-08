function countAsterisks(s) {
    let count = 0;
    let isBarOpen = false;

    for (let char of s) {
        if (char === '|') {
            isBarOpen = !isBarOpen;
        } else if (char === '*' && !isBarOpen) {
            count++;
        }
    }

    return count;
}