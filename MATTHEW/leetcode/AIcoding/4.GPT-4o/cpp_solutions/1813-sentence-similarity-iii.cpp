class Solution {
public:
    bool areSentencesSimilar(string sentence1, string sentence2) {
        vector<string> words1 = split(sentence1);
        vector<string> words2 = split(sentence2);

        if (words1.size() > words2.size()) {
            return areSimilar(words2, words1);
        }
        return areSimilar(words1, words2);
    }

private:
    vector<string> split(const string& sentence) {
        vector<string> words;
        stringstream ss(sentence);
        string word;
        while (ss >> word) {
            words.push_back(word);
        }
        return words;
    }

    bool areSimilar(const vector<string>& shorter, const vector<string>& longer) {
        int n = shorter.size(), m = longer.size();
        int i = 0, j = 0;

        while (i < n && j < m && shorter[i] == longer[j]) {
            i++;
            j++;
        }

        if (i == n) return true; // shorter is a prefix

        while (j < m && i > 0) {
            j++;
            i--;
        }

        while (i < n && j < m && shorter[i] == longer[j]) {
            i++;
            j++;
        }

        return i == n;
    }
};