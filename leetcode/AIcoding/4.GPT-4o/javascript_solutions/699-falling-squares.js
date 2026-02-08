class FallingSquares {
    constructor() {
        this.squares = [];
        this.result = [];
    }

    fallingSquares(pos) {
        const [left, size] = pos;
        const right = left + size;
        let maxHeight = 0;

        for (const [l, r, h] of this.squares) {
            if (l < right && left < r) {
                maxHeight = Math.max(maxHeight, h);
            }
        }

        const newHeight = maxHeight + size;
        this.squares.push([left, right, newHeight]);
        this.result.push(this.result.length === 0 ? newHeight : Math.max(this.result[this.result.length - 1], newHeight));
        return this.result[this.result.length - 1];
    }
}