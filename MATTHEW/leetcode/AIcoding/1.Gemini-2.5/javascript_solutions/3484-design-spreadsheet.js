class Spreadsheet {
    constructor() {
        this.cells = new Map(); // Map<string, { expression: string, value: number, dependencies: Set<string>, dependents: Set<string>, isDirty: boolean }>
    }

    _coordToKey(row, col) {
        return `R${row}C${col}`;
    }

    _parseA1Key(a1Key) {
        let colStr = '';
        let rowStr = '';
        for (let i = 0; i < a1Key.length; i++) {
            if (a1Key[i] >= 'A' && a1Key[i] <= 'Z') {
                colStr += a1Key[i];
            } else {
                rowStr = a1Key.substring(i);
                break;
            }
        }
        let col = 0;
        for (let i = 0; i < colStr.length; i++) {
            col = col * 26 + (colStr.charCodeAt(i) - 'A'.charCodeAt(0) + 1);
        }
        return [parseInt(rowStr), col];
    }

    _parseKeyToCoord(key) {
        const match = key.match(/^R(\d+)C(\d+)$/);
        return [parseInt(match[1]), parseInt(match[2])];
    }

    _getCellData(row, col) {
        const key = this._coordToKey(row, col);
        if (!this.cells.has(key)) {
            this.cells.set(key, {
                expression: "0",
                value: 0,
                dependencies: new Set(),
                dependents: new Set(),
                isDirty: true
            });
        }
        return this.cells.get(key);
    }

    _evaluate(row, col, path = new Set()) {
        const key = this._coordToKey(row, col);
        const cell = this._getCellData(row, col);

        if (path.has(key)) {
            return 0;
        }

        if (!cell.isDirty) {
            return cell.value;
        }

        path.add(key);

        let calculatedValue;
        if (cell.expression.startsWith('=')) {
            let sum = 0;
            const formulaParts = cell.expression.substring(1).split('+');
            for (const part of formulaParts) {
                if (!isNaN(parseInt(part))) {
                    sum += parseInt(part);
                } else {
                    const [depRow, depCol] = this._parseA1Key(part);
                    sum += this._evaluate(depRow, depCol, path);
                }
            }
            calculatedValue = sum;
        } else {
            calculatedValue = parseInt(cell.expression);
        }

        cell.value = calculatedValue;
        cell.isDirty = false;
        path.delete(key);
        return calculatedValue;
    }

    updateCell(row, col, expression) {
        const key = this._coordToKey(row, col);
        const cell = this._getCellData(row, col);

        for (const depKey of cell.dependencies) {
            const [depRow, depCol] = this._parseKeyToCoord(depKey);
            const depCell = this._getCellData(depRow, depCol);
            depCell.dependents.delete(key);
        }
        cell.dependencies.clear();

        cell.expression = expression;

        if (expression.startsWith('=')) {
            const formulaParts = expression.substring(1).split('+');
            for (const part of formulaParts) {
                if (isNaN(parseInt(part))) {
                    const [depRow, depCol] = this._parseA1Key(part);
                    const depKey = this._coordToKey(depRow, depCol);
                    cell.dependencies.add(depKey);
                    const depCell = this._getCellData(depRow, depCol);
                    depCell.dependents.add(key);
                }
            }
        }

        const queue = [key];
        const visited = new Set();
        visited.add(key);
        let head = 0;

        while (head < queue.length) {
            const currentKey = queue[head++];
            const currentCell = this.cells.get(currentKey);
            currentCell.isDirty = true;

            for (const dependentKey of currentCell.dependents) {
                if (!visited.has(dependentKey)) {
                    visited.add(dependentKey);
                    queue.push(dependentKey);
                }
            }
        }
    }

    getCellValue(row, col) {
        return this._evaluate(row, col);
    }

    sumCells(row1, col1, row2, col2) {
        let totalSum = 0;
        for (let r = row1; r <= row2; r++) {
            for (let c = col1; c <= col2; c++) {
                totalSum += this._evaluate(r, c);
            }
        }
        return totalSum;
    }
}