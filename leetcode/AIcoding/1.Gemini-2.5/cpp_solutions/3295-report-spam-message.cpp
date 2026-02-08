#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::vector<bool> reportSpamMessages(std::vector<std::string>& messages, std::vector<std::string>& spamKeywords) {
        std::vector<bool> isSpam(messages.size(), false);

        std::vector<std::string> lowerSpamKeywords;
        for (const std::string& keyword : spamKeywords) {
            std::string lowerKeyword = keyword;
            std::transform(lowerKeyword.begin(), lowerKeyword.end(), lowerKeyword.begin(),
                           [](unsigned char c){ return std::tolower(c); });
            lowerSpamKeywords.push_back(lowerKeyword);
        }

        for (int i = 0; i < messages.size(); ++i) {
            std::string lowerMessage = messages[i];
            std::transform(lowerMessage.begin(), lowerMessage.end(), lowerMessage.begin(),
                           [](unsigned char c){ return std::tolower(c); });

            for (const std::string& keyword : lowerSpamKeywords) {
                if (lowerMessage.find(keyword) != std::string::npos) {
                    isSpam[i] = true;
                    break;
                }
            }
        }

        return isSpam;
    }
};