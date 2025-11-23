#include <vector>
#include <string>
#include <sstream>
#include <unordered_map>

using namespace std;

class Spreadsheet {
public:
    Spreadsheet(int n, int m) : rows(n), cols(m) {
        grid.resize(rows, vector<string>(cols, "0"));
        evalCache.resize(rows, vector<int>(cols, INT_MIN));
    }

    void set(int r, int c, string s) {
        grid[r][c] = s;
        evalCache[r][c] = INT_MIN;
    }

    int get(int r, int c) {
        if (evalCache[r][c] != INT_MIN) {
            return evalCache[r][c];
        }

        string cellValue = grid[r][c];
        if (isdigit(cellValue[0])) {
            try {
                evalCache[r][c] = stoi(cellValue);
            } catch (const std::invalid_argument& ia) {
                evalCache[r][c] = 0;
            } catch (const std::out_of_range& oor) {
                evalCache[r][c] = 0;
            }
            return evalCache[r][c];
        } else if (cellValue.find('+') != string::npos) {
            int sum = 0;
            stringstream ss(cellValue);
            string term;
            while (getline(ss, term, '+')) {
                term.erase(remove_if(term.begin(), term.end(), ::isspace), term.end());
                if (isdigit(term[0])) {
                    try {
                        sum += stoi(term);
                    } catch (const std::invalid_argument& ia) {

                    } catch (const std::out_of_range& oor) {

                    }
                } else {
                    int termRow = term[0] - 'A';
                    int termCol = stoi(term.substr(1)) - 1;
                    sum += get(termRow, termCol);
                }
            }
            evalCache[r][c] = sum;
            return evalCache[r][c];
        } else {
            int refRow = cellValue[0] - 'A';
            int refCol = stoi(cellValue.substr(1)) - 1;
            evalCache[r][c] = get(refRow, refCol);
            return evalCache[r][c];
        }
    }

private:
    int rows;
    int cols;
    vector<vector<string>> grid;
    vector<vector<int>> evalCache;
};