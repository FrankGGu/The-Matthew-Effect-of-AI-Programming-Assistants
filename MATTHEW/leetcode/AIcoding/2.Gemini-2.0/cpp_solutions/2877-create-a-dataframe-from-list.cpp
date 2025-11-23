#include <vector>
#include <string>
#include <sstream>

using namespace std;

struct DataFrame {
    vector<vector<string>> data;
    vector<string> columns;
};

DataFrame createDataFrame(vector<vector<int>>& data, vector<string>& columns) {
    DataFrame df;
    df.columns = columns;
    df.data.resize(data.size());

    for (size_t i = 0; i < data.size(); ++i) {
        df.data[i].resize(data[i].size());
        for (size_t j = 0; j < data[i].size(); ++j) {
            df.data[i][j] = to_string(data[i][j]);
        }
    }

    return df;
}