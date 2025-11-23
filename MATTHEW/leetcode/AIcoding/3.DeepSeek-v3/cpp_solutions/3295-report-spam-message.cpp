#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> reportSpam(vector<string>& messages, vector<string>& spamWords) {
        unordered_set<string> spamSet(spamWords.begin(), spamWords.end());
        unordered_map<int, int> userSpamCount;
        unordered_map<int, int> userTotalMessages;

        for (const string& msg : messages) {
            size_t pos = msg.find(' ');
            int user = stoi(msg.substr(0, pos));
            string content = msg.substr(pos + 1);

            userTotalMessages[user]++;

            vector<string> words;
            size_t start = 0;
            size_t end = content.find(' ');
            while (end != string::npos) {
                words.push_back(content.substr(start, end - start));
                start = end + 1;
                end = content.find(' ', start);
            }
            words.push_back(content.substr(start));

            int spamWordCount = 0;
            for (const string& word : words) {
                if (spamSet.count(word)) {
                    spamWordCount++;
                }
            }

            if (spamWordCount * 2 >= words.size()) {
                userSpamCount[user]++;
            }
        }

        vector<pair<int, double>> userSpamRatio;
        for (const auto& entry : userTotalMessages) {
            int user = entry.first;
            double ratio = (double)userSpamCount[user] / entry.second;
            userSpamRatio.emplace_back(user, ratio);
        }

        sort(userSpamRatio.begin(), userSpamRatio.end(), [](const pair<int, double>& a, const pair<int, double>& b) {
            if (a.second != b.second) {
                return a.second > b.second;
            }
            return a.first > b.first;
        });

        vector<int> result;
        for (const auto& entry : userSpamRatio) {
            result.push_back(entry.first);
        }

        return result;
    }
};