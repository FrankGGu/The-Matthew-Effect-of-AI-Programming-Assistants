class Solution {
public:
    int maximumNumberOfStringPairs(vector<string>& words) {
        unordered_set<string> seen;
        int count = 0;

        for (const string& word : words) {
            string reversedWord = string(word.rbegin(), word.rend());
            if (seen.count(reversedWord)) {
                count++;
                seen.erase(reversedWord);
            } else {
                seen.insert(word);
            }
        }

        return count;
    }
};