#include <vector>

using namespace std;

struct DataFrame {
    vector<vector<int>> data;
};

DataFrame create_new_column(DataFrame df, vector<int> new_column) {
    for (size_t i = 0; i < df.data.size(); ++i) {
        df.data[i].push_back(new_column[i]);
    }
    return df;
}