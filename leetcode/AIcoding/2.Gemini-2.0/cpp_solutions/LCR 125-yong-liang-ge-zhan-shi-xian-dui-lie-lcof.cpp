#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> organizeBooks(vector<int>& shelfA, vector<int>& shelfB) {
        int n = shelfA.size();
        int m = shelfB.size();
        vector<int> combined(shelfA);
        combined.insert(combined.end(), shelfB.begin(), shelfB.end());
        sort(combined.begin(), combined.end());

        vector<vector<int>> result;
        vector<int> a;
        vector<int> b;

        int i = 0, j = 0, k = 0;
        while (k < combined.size()) {
            if (i < n && shelfA[i] == combined[k]) {
                a.push_back(shelfA[i]);
                i++;
            } else if (j < m && shelfB[j] == combined[k]) {
                b.push_back(shelfB[j]);
                j++;
            }
            k++;
        }

        result.push_back(a);
        result.push_back(b);
        return result;
    }
};