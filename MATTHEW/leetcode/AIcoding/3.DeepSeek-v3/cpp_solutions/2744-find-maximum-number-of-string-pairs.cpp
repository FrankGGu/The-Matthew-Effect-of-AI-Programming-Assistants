class Solution {
public:
    int maximumNumberOfStringPairs(vector<string>& words) {
        unordered_set<string> seen;
        int count = 0;
        for (string word : words) {
            string rev = word;
            reverse(rev.begin(), rev.end());
            if (seen.count(rev)) {
                count++;
                seen.erase(rev);
            } else {
                seen.insert(word);
            }
        }
        return count;
    }
};