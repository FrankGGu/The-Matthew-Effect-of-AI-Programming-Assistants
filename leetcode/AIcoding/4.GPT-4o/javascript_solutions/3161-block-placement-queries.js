class BlockPlacement {
    constructor() {
        this.blocks = new Map();
    }

    addBlock(x, y) {
        if (!this.blocks.has(x)) {
            this.blocks.set(x, new Set());
        }
        this.blocks.get(x).add(y);
    }

    removeBlock(x, y) {
        if (this.blocks.has(x)) {
            this.blocks.get(x).delete(y);
            if (this.blocks.get(x).size === 0) {
                this.blocks.delete(x);
            }
        }
    }

    countBlocksInRow(x) {
        return this.blocks.has(x) ? this.blocks.get(x).size : 0;
    }

    countBlocksInCol(y) {
        let count = 0;
        for (let [key, value] of this.blocks) {
            if (value.has(y)) {
                count++;
            }
        }
        return count;
    }
}

var blockPlacementQueries = function(queries) {
    const result = [];
    const bp = new BlockPlacement();

    for (const query of queries) {
        const [type, x, y] = query;
        if (type === 1) {
            bp.addBlock(x, y);
        } else if (type === 2) {
            bp.removeBlock(x, y);
        } else if (type === 3) {
            result.push(bp.countBlocksInRow(x));
        } else if (type === 4) {
            result.push(bp.countBlocksInCol(y));
        }
    }

    return result;
};