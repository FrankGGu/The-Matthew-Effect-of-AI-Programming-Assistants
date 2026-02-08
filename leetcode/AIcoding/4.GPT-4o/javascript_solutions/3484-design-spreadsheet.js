class Spreadsheet {
    constructor() {
        this.sheet = {};
    }

    set(row, col, value) {
        const key = `${row},${col}`;
        this.sheet[key] = value;
    }

    get(row, col) {
        const key = `${row},${col}`;
        return this.sheet[key] !== undefined ? this.sheet[key] : "";
    }

    unset(row, col) {
        const key = `${row},${col}`;
        delete this.sheet[key];
    }

    getRows() {
        const rows = {};
        for (const key in this.sheet) {
            const [row] = key.split(',');
            if (!rows[row]) rows[row] = [];
            rows[row].push(this.sheet[key]);
        }
        return rows;
    }
}