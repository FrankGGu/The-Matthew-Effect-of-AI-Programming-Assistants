#include <string>
#include <unordered_map>
#include <vector>
#include <sstream>
#include <algorithm>

using namespace std;

string largestWordCount(vector<string>& messages, vector<string>& senders) {
    unordered_map<string, int> wordCount;

    for (int i = 0; i < messages.size(); ++i) {
        stringstream ss(messages[i]);
        string word;
        int count = 0;
        while (ss >> word) {
            count++;
        }
        wordCount[senders[i]] += count;
    }

    string result;
    int maxCount = 0;
    for (const auto& [sender, count] : wordCount) {
        if (count > maxCount || (count == maxCount && sender > result)) {
            maxCount = count;
            result = sender;
        }
    }

    return result;
}