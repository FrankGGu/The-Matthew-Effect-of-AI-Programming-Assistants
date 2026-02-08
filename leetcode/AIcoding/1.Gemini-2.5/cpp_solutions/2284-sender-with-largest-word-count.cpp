#include <vector>
#include <string>
#include <map>
#include <sstream>

class Solution {
public:
    std::string largestWordCount(std::vector<std::string>& messages, std::vector<std::string>& senders) {
        std::map<std::string, int> senderWordCounts;

        for (int i = 0; i < messages.size(); ++i) {
            std::string message = messages[i];
            std::string sender = senders[i];

            std::stringstream ss(message);
            std::string word;
            int wordCount = 0;
            while (ss >> word) {
                wordCount++;
            }
            senderWordCounts[sender] += wordCount;
        }

        int maxWordCount = 0;
        std::string resultSender = "";

        for (auto const& [sender, count] : senderWordCounts) {
            if (count > maxWordCount) {
                maxWordCount = count;
                resultSender = sender;
            } else if (count == maxWordCount) {
                if (sender > resultSender) {
                    resultSender = sender;
                }
            }
        }

        return resultSender;
    }
};