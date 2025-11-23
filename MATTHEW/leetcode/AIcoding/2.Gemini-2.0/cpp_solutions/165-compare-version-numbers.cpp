#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int compareVersion(string version1, string version2) {
        vector<int> v1, v2;
        string num;
        for (char c : version1) {
            if (c == '.') {
                v1.push_back(stoi(num));
                num = "";
            } else {
                num += c;
            }
        }
        v1.push_back(stoi(num));

        num = "";
        for (char c : version2) {
            if (c == '.') {
                v2.push_back(stoi(num));
                num = "";
            } else {
                num += c;
            }
        }
        v2.push_back(stoi(num));

        int i = 0, j = 0;
        while (i < v1.size() || j < v2.size()) {
            int val1 = (i < v1.size()) ? v1[i] : 0;
            int val2 = (j < v2.size()) ? v2[j] : 0;

            if (val1 > val2) return 1;
            else if (val1 < val2) return -1;

            i++;
            j++;
        }

        return 0;
    }
};