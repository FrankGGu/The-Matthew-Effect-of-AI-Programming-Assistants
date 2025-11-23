class Solution {
public:
    bool areSentencesSimilar(string sentence1, string sentence2) {
        vector<string> words1, words2;
        stringstream ss1(sentence1), ss2(sentence2);
        string word;

        while (ss1 >> word) words1.push_back(word);
        while (ss2 >> word) words2.push_back(word);

        int n1 = words1.size(), n2 = words2.size();
        if (n1 < n2) {
            swap(words1, words2);
            swap(n1, n2);
        }

        int left = 0;
        while (left < n2 && words1[left] == words2[left]) {
            left++;
        }

        int right = 0;
        while (right < n2 && words1[n1 - 1 - right] == words2[n2 - 1 - right]) {
            right++;
        }

        return left + right >= n2;
    }
};