#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<bool> camelMatch(vector<string>& queries, string pattern) {
        vector<bool> result;
        for (string query : queries) {
            result.push_back(match(query, pattern));
        }
        return result;
    }

private:
    bool match(string query, string pattern) {
        int i = 0, j = 0;
        while (i < query.length() && j < pattern.length()) {
            if (query[i] == pattern[j]) {
                i++;
                j++;
            } else if (isupper(query[i])) {
                return false;
            } else {
                i++;
            }
        }

        while (i < query.length()) {
            if (isupper(query[i])) {
                return false;
            }
            i++;
        }

        return j == pattern.length();
    }
};