#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string getPermutation(int n, int k) {
        vector<int> factorial(n, 1);
        for (int i = 1; i < n; ++i) {
            factorial[i] = factorial[i - 1] * i;
        }

        vector<int> numbers;
        for (int i = 1; i <= n; ++i) {
            numbers.push_back(i);
        }

        k--; // Convert to 0-based index
        string result;

        for (int i = 0; i < n; ++i) {
            int idx = k / factorial[n - 1 - i];
            result += to_string(numbers[idx]);
            numbers.erase(numbers.begin() + idx);
            k %= factorial[n - 1 - i];
        }

        return result;
    }
};