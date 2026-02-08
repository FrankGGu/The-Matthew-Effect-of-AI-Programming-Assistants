#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> vowelStrings(vector<string>& words, vector<vector<int>>& queries) {
        int n = words.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            char first = words[i][0];
            char last = words[i].back();
            if ((first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u') &&
                (last == 'a' || last == 'e' || last == 'i' || last == 'o' || last == 'u')) {
                prefix[i + 1] = prefix[i] + 1;
            } else {
                prefix[i + 1] = prefix[i];
            }
        }

        vector<int> result;
        for (const auto& query : queries) {
            int left = query[0];
            int right = query[1];
            result.push_back(prefix[right + 1] - prefix[left]);
        }

        return result;
    }
};