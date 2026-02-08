#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>

using namespace std;

vector<pair<string, int>> countMentions(vector<string>& posts) {
    unordered_map<string, int> mentionCount;
    for (const string& post : posts) {
        stringstream ss(post);
        string word;
        while (ss >> word) {
            if (word.size() > 1 && word[0] == '@') {
                mentionCount[word.substr(1)]++;
            }
        }
    }
    vector<pair<string, int>> result(mentionCount.begin(), mentionCount.end());
    return result;
}