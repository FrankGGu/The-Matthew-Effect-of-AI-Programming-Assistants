class Solution {
public:
    vector<int> splitIntoFibonacci(string S) {
        vector<int> result;
        int n = S.size();

        for (int i = 1; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                result.clear();
                long num1 = stol(S.substr(0, i));
                long num2 = stol(S.substr(i, j - i));

                if (to_string(num1).size() != i || to_string(num2).size() != (j - i)) continue;

                result.push_back(num1);
                result.push_back(num2);

                string nextFibo;
                while (j < n) {
                    long num3 = num1 + num2;
                    nextFibo = to_string(num3);
                    if (S.substr(j, nextFibo.size()) != nextFibo) break;
                    result.push_back(num3);
                    j += nextFibo.size();
                    num1 = num2;
                    num2 = num3;
                }

                if (j == n && result.size() >= 3) return result;
            }
        }

        return {};
    }
};