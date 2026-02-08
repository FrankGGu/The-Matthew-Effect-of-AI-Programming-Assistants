#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> reportSpamMessages(vector<vector<int>>& messages, int threshold) {
        unordered_map<int, int> userMessageCount;
        for (const auto& message : messages) {
            userMessageCount[message[0]]++;
        }

        vector<int> spamUsers;
        for (auto const& [user, count] : userMessageCount) {
            if (count >= threshold) {
                spamUsers.push_back(user);
            }
        }

        sort(spamUsers.begin(), spamUsers.end());
        return spamUsers;
    }
};