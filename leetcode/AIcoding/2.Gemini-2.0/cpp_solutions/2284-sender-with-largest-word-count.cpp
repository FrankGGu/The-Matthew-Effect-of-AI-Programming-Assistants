#include <vector>
#include <string>
#include <sstream>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string largestWordCount(vector<string>& messages, vector<string>& senders) {
        unordered_map<string, int> word_counts;
        for (int i = 0; i < messages.size(); ++i) {
            stringstream ss(messages[i]);
            string word;
            int count = 0;
            while (ss >> word) {
                count++;
            }
            word_counts[senders[i]] += count;
        }

        string max_sender = "";
        int max_count = 0;
        for (auto const& [sender, count] : word_counts) {
            if (count > max_count) {
                max_count = count;
                max_sender = sender;
            } else if (count == max_count) {
                if (sender > max_sender) {
                    max_sender = sender;
                }
            }
        }

        return max_sender;
    }
};