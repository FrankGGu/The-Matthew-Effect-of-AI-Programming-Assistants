class Solution {
public:
    string largestWordCount(vector<string>& messages, vector<string>& senders) {
        unordered_map<string, int> wordCount;
        string result;
        int maxCount = 0;

        for (int i = 0; i < messages.size(); ++i) {
            int count = 1;
            for (char c : messages[i]) {
                if (c == ' ') {
                    count++;
                }
            }
            wordCount[senders[i]] += count;

            if (wordCount[senders[i]] > maxCount || 
                (wordCount[senders[i]] == maxCount && senders[i] > result)) {
                maxCount = wordCount[senders[i]];
                result = senders[i];
            }
        }

        return result;
    }
};