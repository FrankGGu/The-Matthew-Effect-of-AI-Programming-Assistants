function findSneakyNumbers(n) {
    let missingNumbers = [];
    for (let i = 1; i <= n; i++) {
        if ((i % 7 !== 0) && (i.toString().indexOf('7') === -1)) {
            missingNumbers.push(i);
        }
    }
    return missingNumbers.slice(-2);
}