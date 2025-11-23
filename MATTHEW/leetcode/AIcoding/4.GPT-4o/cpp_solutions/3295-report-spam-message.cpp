class Solution {
public:
    int reportSpam(vector<string>& messages, string spam) {
        int count = 0;
        for (const auto& message : messages) {
            if (message.find(spam) != string::npos) {
                count++;
            }
        }
        return count;
    }
};