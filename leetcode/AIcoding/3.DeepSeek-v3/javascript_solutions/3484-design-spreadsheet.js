class Excel {
    constructor(height, char) {
        this.height = height;
        this.width = char.charCodeAt(0) - 'A'.charCodeAt(0) + 1;
        this.grid = new Array(this.height);
        for (let i = 0; i < this.height; i++) {
            this.grid[i] = new Array(this.width).fill(0);
        }
        this.formulas = {};
    }

    set(row, column, val) {
        const key = `${row},${column}`;
        delete this.formulas[key];
        this.grid[row - 1][column.charCodeAt(0) - 'A'.charCodeAt(0)] = val;
    }

    get(row, column) {
        const key = `${row},${column}`;
        if (key in this.formulas) {
            return this.calculateFormula(key);
        } else {
            return this.grid[row - 1][column.charCodeAt(0) - 'A'.charCodeAt(0)];
        }
    }

    sum(row, column, numbers) {
        const key = `${row},${column}`;
        this.formulas[key] = numbers;
        return this.calculateFormula(key);
    }

    calculateFormula(key) {
        const numbers = this.formulas[key];
        let sum = 0;
        for (const item of numbers) {
            if (item.includes(':')) {
                const [start, end] = item.split(':');
                const [startRow, startCol] = this.parseCell(start);
                const [endRow, endCol] = this.parseCell(end);
                for (let r = startRow; r <= endRow; r++) {
                    for (let c = startCol; c <= endCol; c++) {
                        sum += this.getCellValue(r, c);
                    }
                }
            } else {
                const [r, c] = this.parseCell(item);
                sum += this.getCellValue(r, c);
            }
        }
        this.grid[parseInt(key.split(',')[0]) - 1][key.split(',')[1].charCodeAt(0) - 'A'.charCodeAt(0)] = sum;
        return sum;
    }

    parseCell(cell) {
        const col = cell[0];
        const row = parseInt(cell.substring(1));
        return [row, col];
    }

    getCellValue(row, col) {
        const key = `${row},${col}`;
        if (key in this.formulas) {
            return this.calculateFormula(key);
        } else {
            return this.grid[row - 1][col.charCodeAt(0) - 'A'.charCodeAt(0)];
        }
    }
}