class Spreadsheet {
public:
    unordered_map<int, unordered_map<int, string>> data;
    unordered_map<int, unordered_map<int, int>> formula;

    Spreadsheet() {}

    void set(int row, int col, string val) {
        data[row][col] = val;
        formula[row][col] = 0; // Reset formula flag
    }

    string get(int row, int col) {
        if (data.count(row) && data[row].count(col)) {
            return data[row][col];
        }
        return "";
    }

    void setFormula(int row, int col, string formulaStr) {
        formula[row][col] = 1; // Mark as formula
        data[row][col] = formulaStr;
    }

    string getFormula(int row, int col) {
        if (data.count(row) && data[row].count(col)) {
            return data[row][col];
        }
        return "";
    }

    void recalculate(int row, int col) {
        if (formula.count(row) && formula[row].count(col)) {
            // Evaluate the formula here
        }
    }
};