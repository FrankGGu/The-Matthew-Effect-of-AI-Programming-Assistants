#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTimeToInitialState(string word, int k) {
        int n = word.length();
        int count = 0;
        for (int i = k; i < n; i += k) {
            string sub = word.substr(i);
            if (word.rfind(sub, 0) == 0) {
                break;
            }
            count++;
        }
        if (count == 0) return 1;
        return count + 1;
    }
};