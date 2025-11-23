#include <vector>
#include <string>

using namespace std;

vector<vector<string>> displayFirstThreeRows(vector<vector<string>>& df) {
    if (df.size() <= 3) {
        return df;
    } else {
        return vector<vector<string>>(df.begin(), df.begin() + 3);
    }
}