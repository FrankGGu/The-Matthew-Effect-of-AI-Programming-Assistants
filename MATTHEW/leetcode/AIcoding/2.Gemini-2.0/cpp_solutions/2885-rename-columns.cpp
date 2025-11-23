#include <vector>
#include <string>

using namespace std;

struct DataFrame {
  vector<vector<int>> data;
  vector<string> columns;
};

DataFrame renameColumns(DataFrame df, vector<string> new_columns) {
  df.columns = new_columns;
  return df;
}