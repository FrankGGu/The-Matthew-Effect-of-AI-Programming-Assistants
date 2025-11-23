#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(string word, int k) {
        int n = word.size();
        if (n % k != 0) return -1;
        int periods = n / k;
        int operations = 0;
        for (int i = 0; i < k; ++i) {
            int counts[26] = {0};
            for (int j = 0; j < periods; ++j) {
                counts[word[i + j * k] - 'a']++;
            }
            int max_count = 0;
            for (int j = 0; j < 26; ++j) {
                max_count = max(max_count, counts[j]);
            }
            operations += (periods - max_count);
        }
        return operations;
    }
};