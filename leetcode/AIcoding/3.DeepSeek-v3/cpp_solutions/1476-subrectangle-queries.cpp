class SubrectangleQueries {
private:
    vector<vector<int>> rectangle;
    vector<vector<int>> updates;

public:
    SubrectangleQueries(vector<vector<int>>& rectangle) {
        this->rectangle = rectangle;
    }

    void updateSubrectangle(int row1, int col1, int row2, int col2, int newValue) {
        updates.push_back({row1, col1, row2, col2, newValue});
    }

    int getValue(int row, int col) {
        for (int i = updates.size() - 1; i >= 0; --i) {
            auto& update = updates[i];
            if (row >= update[0] && row <= update[2] && col >= update[1] && col <= update[3]) {
                return update[4];
            }
        }
        return rectangle[row][col];
    }
};