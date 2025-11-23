class Excel {
public:
    Excel(int height, char width) {
        h = height;
        w = width - 'A' + 1;
        grid.resize(h + 1, vector<int>(w + 1, 0));
        formulas.resize(h + 1, vector<string>(w + 1, ""));
    }

    void set(int row, char column, int val) {
        int c = column - 'A' + 1;
        formulas[row][c] = "";
        updateCell(row, c, val);
    }

    int get(int row, char column) {
        int c = column - 'A' + 1;
        return grid[row][c];
    }

    int sum(int row, char column, vector<string> numbers) {
        int c = column - 'A' + 1;
        formulas[row][c] = "sum";
        sumMap[{row, c}] = parseNumbers(numbers);
        updateSum(row, c);
        return grid[row][c];
    }

private:
    int h, w;
    vector<vector<int>> grid;
    vector<vector<string>> formulas;
    map<pair<int, int>, vector<pair<int, int>>> sumMap;

    void updateCell(int row, int col, int val) {
        int delta = val - grid[row][col];
        grid[row][col] = val;
        for (int i = 1; i <= h; ++i) {
            for (int j = 1; j <= w; ++j) {
                if (formulas[i][j] == "sum") {
                    for (auto& cellList : sumMap) {
                        auto& cells = cellList.second;
                        for (auto& cell : cells) {
                            if (cell.first == row && cell.second == col) {
                                updateSum(i, j);
                            }
                        }
                    }
                }
            }
        }
    }

    void updateSum(int row, int col) {
        int total = 0;
        for (auto& cell : sumMap[{row, col}]) {
            total += grid[cell.first][cell.second];
        }
        grid[row][col] = total;
    }

    vector<pair<int, int>> parseNumbers(vector<string>& numbers) {
        vector<pair<int, int>> res;
        for (string& s : numbers) {
            size_t colon = s.find(':');
            if (colon == string::npos) {
                int c = s[0] - 'A' + 1;
                int r = stoi(s.substr(1));
                res.push_back({r, c});
            } else {
                string topLeft = s.substr(0, colon);
                string bottomRight = s.substr(colon + 1);
                int c1 = topLeft[0] - 'A' + 1;
                int r1 = stoi(topLeft.substr(1));
                int c2 = bottomRight[0] - 'A' + 1;
                int r2 = stoi(bottomRight.substr(1));
                for (int r = r1; r <= r2; ++r) {
                    for (int c = c1; c <= c2; ++c) {
                        res.push_back({r, c});
                    }
                }
            }
        }
        return res;
    }
};