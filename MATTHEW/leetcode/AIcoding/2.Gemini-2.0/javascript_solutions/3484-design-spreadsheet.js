class Spreadsheet {
    constructor(rows, cols) {
        this.rows = rows;
        this.cols = cols;
        this.cells = Array(rows).fill(null).map(() => Array(cols).fill(""));
        this.formula = Array(rows).fill(null).map(() => Array(cols).fill(""));
        this.cache = Array(rows).fill(null).map(() => Array(cols).fill(null));
    }

    set(row, col, s) {
        this.cells[row][col] = s;
        this.formula[row][col] = "";
        this.cache[row][col] = null;
    }

    get(row, col) {
        if (this.cache[row][col] !== null) {
            return this.cache[row][col];
        }

        if (this.formula[row][col] === "") {
            let val = parseInt(this.cells[row][col]);
            if (isNaN(val)) {
                val = 0;
            }
            this.cache[row][col] = val;
            return val;
        }

        let expression = this.formula[row][col];
        let tokens = expression.split(" ");
        let sum = 0;
        for (let i = 0; i < tokens.length; i++) {
            if (tokens[i] === "SUM") {
                let range = tokens[i + 1].split(":");
                let start = range[0];
                let end = range[1];

                let startRow = parseInt(start.substring(1)) - 1;
                let startCol = start.charCodeAt(0) - 'A'.charCodeAt(0);
                let endRow = parseInt(end.substring(1)) - 1;
                let endCol = end.charCodeAt(0) - 'A'.charCodeAt(0);

                for (let r = startRow; r <= endRow; r++) {
                    for (let c = startCol; c <= endCol; c++) {
                        sum += this.get(r, c);
                    }
                }
                i++;
            } else {
                let cell = tokens[i];
                let r = parseInt(cell.substring(1)) - 1;
                let c = cell.charCodeAt(0) - 'A'.charCodeAt(0);
                sum += this.get(r, c);
            }
        }
        this.cache[row][col] = sum;
        return sum;
    }

    sum(row, col, numbers) {
        this.formula[row][col] = "SUM " + numbers.join(" ");
        this.cache[row][col] = null;
    }
}