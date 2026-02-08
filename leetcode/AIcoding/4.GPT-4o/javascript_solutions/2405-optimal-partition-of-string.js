function partitionString(s) {
    let count = 0;
    let charSet = new Set();

    for (let char of s) {
        if (charSet.has(char)) {
            count++;
            charSet.clear();
        }
        charSet.add(char);
    }

    return count + (charSet.size > 0 ? 1 : 0);
}