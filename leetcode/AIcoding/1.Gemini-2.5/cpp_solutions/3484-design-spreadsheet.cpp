#include <vector>
#include <string>
#include <map>
#include <set>
#include <queue>
#include <sstream> // For stringstream to parse formulas
#include <utility> // For std::pair

class Spreadsheet {
private:
    int R, C;
    std::vector<std::vector<int>> values;
    std::vector<std::vector<std::string>> formulas;

    // dependents[cell_A] stores cells that depend on cell_A
    std::map<std::pair<int, int>, std::set<std::pair<int, int>>> dependents;
    // dependencies[cell_A] stores cells that cell_A depends on
    std::map<std::pair<int, int>, std::set<std::pair<int, int>>> dependencies;

    // Helper to parse "A1" into {0, 0}
    std::pair<int, int> parseCellRef(const std::string& s) {
        int col = s[0] - 'A';
        int row = std::stoi(s.substr(1)) - 1;
        return {row, col};
    }

    // Helper to clear dependencies for a cell (r, c)
    void clearCellDependencies(int r, int c) {
        // Only clear if it was a formula, otherwise there are no dependencies to clear
        if (formulas[r][c][0] == '=') {
            // For each cell that (r,c) used to depend on, remove (r,c) from its dependents list
            for (const auto& dep_cell : dependencies[{r, c}]) {
                dependents[dep_cell].erase({r, c});
            }
        }
        // Clear the list of cells that (r,c) depends on
        dependencies[{r, c}].clear();
    }

    // Helper to evaluate a cell's formula and update its value and dependencies
    // Assumes old dependencies for (r, c) have been cleared.
    void evaluateCell(int r, int c) {
        const std::string& formula_str = formulas[r][c];
        if (formula_str[0] != '=') {
            // It's a plain number
            values[r][c] = std::stoi(formula_str);
            // No dependencies to establish for a plain number
        } else {
            // It's a formula
            int current_val = 0;
            std::string expr = formula_str.substr(1);
            std::stringstream ss(expr);
            std::string segment;

            // Parse the expression by '+'
            while (std::getline(ss, segment, '+')) {
                std::pair<int, int> ref_cell = parseCellRef(segment);
                current_val += values[ref_cell.first][ref_cell.second];

                // Establish new dependency: (r,c) depends on ref_cell
                dependencies[{r, c}].insert(ref_cell);
                // Establish new dependent: ref_cell has (r,c) as a dependent
                dependents[ref_cell].insert({r, c});
            }
            values[r][c] = current_val;
        }
    }

public:
    Spreadsheet(int n_rows, int n_cols) : R(n_rows), C(n_cols) {
        values.assign(R, std::vector<int>(C, 0));
        formulas.assign(R, std::vector<std::string>(C, "0"));
    }

    void set(int r, int c, const std::string& s) {
        // 1. Clear old dependencies for (r, c)
        clearCellDependencies(r, c);

        // 2. Update formula string
        formulas[r][c] = s;

        // 3. Evaluate (r, c) and establish new dependencies
        evaluateCell(r, c);

        // 4. Re-evaluate all cells that depend on (r, c) using BFS
        std::queue<std::pair<int, int>> q;
        std::set<std::pair<int, int>> visited;

        // Add direct dependents of (r, c) to the queue for re-evaluation
        // The `dependents` map for `(r,c)` now reflects cells that depend on the *new* `(r,c)`.
        for (const auto& dep_cell : dependents[{r, c}]) {
            if (visited.find(dep_cell) == visited.end()) {
                q.push(dep_cell);
                visited.insert(dep_cell);
            }
        }

        while (!q.empty()) {
            std::pair<int, int> curr_cell = q.front();
            q.pop();

            // Re-evaluate the current cell
            // First, clear its old dependencies (which might be based on previous values/formulas)
            clearCellDependencies(curr_cell.first, curr_cell.second);
            // Then, evaluate it with current values of its dependencies
            evaluateCell(curr_cell.first, curr_cell.second);

            // Add its dependents to the queue for further propagation
            for (const auto& next_dep_cell : dependents[curr_cell]) {
                if (visited.find(next_dep_cell) == visited.end()) {
                    q.push(next_dep_cell);
                    visited.insert(next_dep_cell);
                }
            }
        }
    }

    int get(int r, int c) {
        return values[r][c];
    }
};