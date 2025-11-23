var construct = function(grid) {
    const n = grid.length;

    function build(r, c, size) {
        let isUniform = true;
        const firstVal = grid[r][c];

        for (let i = 0; i < size; i++) {
            for (let j = 0; j < size; j++) {
                if (grid[r + i][c + j] !== firstVal) {
                    isUniform = false;
                    break;
                }
            }
            if (!isUniform) {
                break;
            }
        }

        if (isUniform) {
            return new Node(firstVal, true, null, null, null, null);
        } else {
            const node = new Node(1, false, null, null, null, null);
            const halfSize = size / 2;

            node.topLeft = build(r, c, halfSize);
            node.topRight = build(r, c + halfSize, halfSize);
            node.bottomLeft = build(r + halfSize, c, halfSize);
            node.bottomRight = build(r + halfSize, c + halfSize, halfSize);

            return node;
        }
    }

    return build(0, 0, n);
};