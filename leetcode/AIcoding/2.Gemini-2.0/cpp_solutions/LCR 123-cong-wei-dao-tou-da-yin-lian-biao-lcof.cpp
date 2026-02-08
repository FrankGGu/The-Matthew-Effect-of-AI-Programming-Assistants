#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> arrangeBooks(vector<int>& books) {
        int n = books.size();
        vector<vector<int>> result;
        vector<int> current;
        vector<bool> used(n, false);

        function<void(void)> backtrack = [&]() {
            if (current.size() == n) {
                result.push_back(current);
                return;
            }

            for (int i = 0; i < n; ++i) {
                if (!used[i]) {
                    used[i] = true;
                    current.push_back(books[i]);
                    backtrack();
                    current.pop_back();
                    used[i] = false;
                }
            }
        };

        backtrack();
        return result;
    }
};