class BlockManager {
    constructor() {
        this.blocks = [];
    }

    placeBlock(pos, size) {
        let left = pos;
        let right = pos + size - 1;
        let newBlocks = [];
        let inserted = false;

        for (const block of this.blocks) {
            if (block[1] < left - 1) {
                newBlocks.push(block);
            } else if (block[0] > right + 1) {
                if (!inserted) {
                    newBlocks.push([left, right]);
                    inserted = true;
                }
                newBlocks.push(block);
            } else {
                left = Math.min(left, block[0]);
                right = Math.max(right, block[1]);
            }
        }

        if (!inserted) {
            newBlocks.push([left, right]);
        }

        newBlocks.sort((a, b) => a[0] - b[0]);
        this.blocks = newBlocks;
    }

    querySpace(left, right) {
        for (const block of this.blocks) {
            if (block[0] <= left && block[1] >= right) {
                return false;
            }
            if (block[0] > right) {
                break;
            }
        }
        return true;
    }
}

var Solution = function() {
    this.manager = new BlockManager();
};

Solution.prototype.placeBlock = function(pos, size) {
    this.manager.placeBlock(pos, size);
};

Solution.prototype.query = function(left, right) {
    return this.manager.querySpace(left, right);
};