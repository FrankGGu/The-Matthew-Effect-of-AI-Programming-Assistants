#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string solve() {
        int n;
        cin >> n;
        vector<pair<int, int>> periods(n);
        for (int i = 0; i < n; ++i) {
            cin >> periods[i].first >> periods[i].second;
        }

        int year;
        cin >> year;

        string result = "Unknown";
        for (const auto& period : periods) {
            if (year >= period.first && year <= period.second) {
                result = "True";
                return result;
            }
        }
        return result;
    }
};