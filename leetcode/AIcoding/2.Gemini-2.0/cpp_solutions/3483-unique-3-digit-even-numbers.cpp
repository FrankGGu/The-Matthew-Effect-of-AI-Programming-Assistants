#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findEvenNumbers(vector<int>& digits) {
        vector<int> result;
        vector<bool> used(digits.size(), false);

        function<void(vector<int>&)> solve = [&](vector<int>& current) {
            if (current.size() == 3) {
                int num = current[0] * 100 + current[1] * 10 + current[2];
                if (num >= 100 && num % 2 == 0) {
                    result.push_back(num);
                }
                return;
            }

            for (int i = 0; i < digits.size(); ++i) {
                if (!used[i]) {
                    used[i] = true;
                    current.push_back(digits[i]);
                    solve(current);
                    current.pop_back();
                    used[i] = false;
                }
            }
        };

        vector<int> current;
        solve(current);

        sort(result.begin(), result.end());
        result.erase(unique(result.begin(), result.end()), result.end());

        return result;
    }
};