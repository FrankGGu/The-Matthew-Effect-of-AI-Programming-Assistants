#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> countMentionsPerUser(int n, vector<vector<string>>& discussions) {
        unordered_map<string, unordered_set<int>> userToMentions;
        for (const auto& discussion : discussions) {
            int postId = stoi(discussion[0]);
            string content = discussion[1];
            unordered_set<string> mentionedUsers;
            size_t pos = 0;
            while (pos < content.size()) {
                if (content[pos] == '@') {
                    size_t start = pos + 1;
                    while (start < content.size() && isalnum(content[start])) {
                        start++;
                    }
                    string username = content.substr(pos + 1, start - pos - 1);
                    if (!username.empty()) {
                        mentionedUsers.insert(username);
                    }
                    pos = start;
                } else {
                    pos++;
                }
            }
            for (const auto& user : mentionedUsers) {
                userToMentions[user].insert(postId);
            }
        }
        vector<int> result(n, 0);
        for (const auto& entry : userToMentions) {
            string user = entry.first;
            if (user.size() >= 1 && isdigit(user[0])) {
                int userId = stoi(user);
                if (userId >= 1 && userId <= n) {
                    result[userId - 1] = entry.second.size();
                }
            }
        }
        return result;
    }
};