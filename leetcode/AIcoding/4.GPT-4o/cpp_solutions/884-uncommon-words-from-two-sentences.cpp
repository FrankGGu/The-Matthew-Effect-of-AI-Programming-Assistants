#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>

using namespace std;

vector<string> uncommonFromSentences(string A, string B) {
    unordered_map<string, int> count;
    istringstream streamA(A), streamB(B);
    string word;

    while (streamA >> word) {
        count[word]++;
    }
    while (streamB >> word) {
        count[word]++;
    }

    vector<string> result;
    for (const auto& pair : count) {
        if (pair.second == 1) {
            result.push_back(pair.first);
        }
    }

    return result;
}