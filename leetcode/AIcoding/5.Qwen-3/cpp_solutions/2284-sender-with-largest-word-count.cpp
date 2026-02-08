#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string largestWordCount(vector<string>& messages) {
        unordered_map<string, int> senderCount;
        string maxSender = "";
        int maxCount = 0;

        for (const string& message : messages) {
            size_t pos = message.find(" ");
            string sender = message.substr(0, pos);
            string content = message.substr(pos + 1);

            int wordCount = 1;
            for (char c : content) {
                if (c == ' ') {
                    wordCount++;
                }
            }

            senderCount[sender] += wordCount;

            if (senderCount[sender] > maxCount || (senderCount[sender] == maxCount && sender < maxSender)) {
                maxCount = senderCount[sender];
                maxSender = sender;
            }
        }

        return maxSender;
    }
};