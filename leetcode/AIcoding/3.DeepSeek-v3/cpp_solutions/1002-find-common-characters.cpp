using namespace std;

class Solution {
public:
    vector<string> commonChars(vector<string>& words) {
        vector<int> minFreq(26, INT_MAX);
        vector<string> result;

        for (const string& word : words) {
            vector<int> freq(26, 0);
            for (char c : word) {
                freq[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                minFreq[i] = min(minFreq[i], freq[i]);
            }
        }

        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < minFreq[i]; j++) {
                result.push_back(string(1, 'a' + i));
            }
        }

        return result;
    }
};