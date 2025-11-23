function repeatedStringMatch(A, B) {
    let count = Math.ceil(B.length / A.length);
    let repeatedA = A.repeat(count);

    if (repeatedA.includes(B)) return count;
    if (repeatedA + A.includes(B)) return count + 1;

    return -1;
}