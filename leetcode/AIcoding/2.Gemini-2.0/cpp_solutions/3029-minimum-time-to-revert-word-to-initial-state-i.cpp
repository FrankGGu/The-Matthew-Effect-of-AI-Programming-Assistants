#include <string>

using namespace std;

class Solution {
public:
    int minimumTimeToInitialState(string word, int k) {
        int n = word.size();
        int count = 0;
        for (int i = k; i < n; i += k) {
            bool match = true;
            for (int j = 0; j < n - i; ++j) {
                if (word[j] != word[i + j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return count + 1;
            }
            count++;
        }
        return count + 1;
    }
};