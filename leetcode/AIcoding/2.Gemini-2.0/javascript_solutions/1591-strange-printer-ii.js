var isPrintable = function(targetGrid) {
    const m = targetGrid.length;
    const n = targetGrid[0].length;
    const colors = new Set();
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            colors.add(targetGrid[i][j]);
        }
    }

    const colorBounds = new Map();
    for (const color of colors) {
        colorBounds.set(color, { minRow: m, maxRow: -1, minCol: n, maxCol: -1 });
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const color = targetGrid[i][j];
            const bounds = colorBounds.get(color);
            bounds.minRow = Math.min(bounds.minRow, i);
            bounds.maxRow = Math.max(bounds.maxRow, i);
            bounds.minCol = Math.min(bounds.minCol, j);
            bounds.maxCol = Math.max(bounds.maxCol, j);
        }
    }

    const adj = new Map();
    for (const color of colors) {
        adj.set(color, new Set());
    }

    for (const color1 of colors) {
        for (const color2 of colors) {
            if (color1 === color2) continue;
            const bounds1 = colorBounds.get(color1);
            const bounds2 = colorBounds.get(color2);

            if (bounds1.minRow <= bounds2.maxRow && bounds1.maxRow >= bounds2.minRow &&
                bounds1.minCol <= bounds2.maxCol && bounds1.maxCol >= bounds2.minCol) {
                let overlap = true;
                for (let i = bounds2.minRow; i <= bounds2.maxRow; i++) {
                    for (let j = bounds2.minCol; j <= bounds2.maxCol; j++) {
                        if (targetGrid[i][j] !== color1 && targetGrid[i][j] !== color2) {
                            overlap = false;
                            break;
                        }
                        if (targetGrid[i][j] === color1) {

                        }
                    }
                    if (!overlap) break;
                }
                if (overlap) {
                    adj.get(color1).add(color2);
                }
            }
        }
    }

    const visited = new Set();
    const recursionStack = new Set();

    function hasCycle(node) {
        visited.add(node);
        recursionStack.add(node);

        for (const neighbor of adj.get(node)) {
            if (!visited.has(neighbor)) {
                if (hasCycle(neighbor)) {
                    return true;
                }
            } else if (recursionStack.has(neighbor)) {
                return true;
            }
        }

        recursionStack.delete(node);
        return false;
    }

    for (const color of colors) {
        if (!visited.has(color)) {
            if (hasCycle(color)) {
                return false;
            }
        }
    }

    return true;
};