function minOperations(n) {
    let operations = 0;
    for (let i = 1; i < n; i += 2) {
        operations += (n - i) / 2;
    }
    return operations;
}