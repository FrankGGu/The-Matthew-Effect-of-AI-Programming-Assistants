function minOperations(s) {
    let n = s.length;
    let count = new Array(26).fill(0);

    for (let char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let operations = 0;
    let expected = 0;

    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            expected++;
            operations += count[i] - expected;
        }
    }

    return operations;
}