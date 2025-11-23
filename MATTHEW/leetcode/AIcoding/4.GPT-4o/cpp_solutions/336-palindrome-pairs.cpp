class Solution {
public:
    vector<vector<int>> palindromePairs(vector<string>& words) {
        unordered_map<string, int> wordIndex;
        vector<vector<int>> result;

        for (int i = 0; i < words.size(); ++i) {
            wordIndex[words[i]] = i;
        }

        for (int i = 0; i < words.size(); ++i) {
            string word = words[i];
            int len = word.size();
            for (int j = 0; j <= len; ++j) {
                string left = word.substr(0, j);
                string right = word.substr(j);
                if (isPalindrome(left)) {
                    string revRight = string(right.rbegin(), right.rend());
                    if (wordIndex.count(revRight) && wordIndex[revRight] != i) {
                        result.push_back({wordIndex[revRight], i});
                    }
                }
                if (j < len && isPalindrome(right)) {
                    string revLeft = string(left.rbegin(), left.rend());
                    if (wordIndex.count(revLeft) && wordIndex[revLeft] != i) {
                        result.push_back({i, wordIndex[revLeft]});
                    }
                }
            }
        }

        return result;
    }

private:
    bool isPalindrome(const string& s) {
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) return false;
            left++;
            right--;
        }
        return true;
    }
};