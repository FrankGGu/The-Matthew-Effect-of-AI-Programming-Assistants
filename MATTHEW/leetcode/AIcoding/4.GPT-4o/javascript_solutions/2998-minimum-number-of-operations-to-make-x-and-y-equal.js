function minOperations(X, Y) {
    let diff = Math.abs(X - Y);
    let operations = 0;

    while (diff > 0) {
        operations++;
        diff -= operations;
    }

    return (diff === 0) ? operations : (diff < 0 && (operations % 2 === 0)) ? operations + 1 : operations + 2;
}