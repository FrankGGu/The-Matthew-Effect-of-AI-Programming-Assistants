#include <vector>
#include <algorithm>

struct DataFrame {
    std::vector<std::vector<int>> data;
};

DataFrame dropDuplicateRows(DataFrame df) {
    std::vector<std::vector<int>> unique_rows;
    std::sort(df.data.begin(), df.data.end());
    for (const auto& row : df.data) {
        if (unique_rows.empty() || row != unique_rows.back()) {
            unique_rows.push_back(row);
        }
    }
    df.data = unique_rows;
    return df;
}