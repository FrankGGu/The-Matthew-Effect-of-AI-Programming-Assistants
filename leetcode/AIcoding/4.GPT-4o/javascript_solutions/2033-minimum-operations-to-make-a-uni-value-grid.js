var minOperations = function(grid, x) {
    const flatGrid = grid.flat();
    const min = Math.min(...flatGrid);
    const operations = flatGrid.map(num => (num - min) % x === 0 ? (num - min) / x : -1);

    if (operations.includes(-1)) return -1;

    operations.sort((a, b) => a - b);
    const median = operations[Math.floor(operations.length / 2)];

    return operations.reduce((acc, op) => acc + Math.abs(op - median), 0);
};