#include <vector>
#include <string>

using namespace std;

vector<vector<string>> changeDataType(vector<vector<string>>& data) {
    for (auto& row : data) {
        for (auto& cell : row) {
            try {
                stoi(cell);
                cell = "int";
            } catch (...) {
                try {
                    stod(cell);
                    cell = "float";
                } catch (...) {
                    cell = "string";
                }
            }
        }
    }
    return data;
}