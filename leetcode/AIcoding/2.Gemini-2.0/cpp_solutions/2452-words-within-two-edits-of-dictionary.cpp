#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> twoEditWords(vector<string>& queries, vector<string>& dictionary) {
        vector<string> result;
        for (const string& query : queries) {
            for (const string& dictWord : dictionary) {
                if (query.length() != dictWord.length()) continue;
                int diff = 0;
                for (int i = 0; i < query.length(); ++i) {
                    if (query[i] != dictWord[i]) {
                        diff++;
                    }
                }
                if (diff <= 2) {
                    result.push_back(query);
                    break;
                }
            }
        }
        return result;
    }
};