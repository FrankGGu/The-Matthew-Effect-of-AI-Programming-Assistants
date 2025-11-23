#include <vector>

using namespace std;

class Solution {
public:
    vector<int> processQueries(vector<int>& queries, int m) {
        vector<int> P(m);
        for (int i = 0; i < m; ++i) {
            P[i] = i + 1;
        }

        vector<int> result;
        for (int query : queries) {
            int index = 0;
            for (int i = 0; i < m; ++i) {
                if (P[i] == query) {
                    index = i;
                    break;
                }
            }
            result.push_back(index);

            int temp = P[index];
            for (int i = index; i > 0; --i) {
                P[i] = P[i - 1];
            }
            P[0] = temp;
        }

        return result;
    }
};