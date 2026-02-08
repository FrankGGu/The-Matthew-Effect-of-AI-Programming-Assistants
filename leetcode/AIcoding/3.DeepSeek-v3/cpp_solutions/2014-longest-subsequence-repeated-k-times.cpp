class Solution {
public:
    string longestSubsequenceRepeatedK(string s, int k) {
        string res;
        queue<string> q;
        q.push("");
        while (!q.empty()) {
            int size = q.size();
            while (size--) {
                string curr = q.front();
                q.pop();
                for (char c = 'a'; c <= 'z'; ++c) {
                    string next = curr + c;
                    if (isSubsequenceRepeatedK(s, next, k)) {
                        res = next;
                        q.push(next);
                    }
                }
            }
        }
        return res;
    }

    bool isSubsequenceRepeatedK(const string& s, const string& sub, int k) {
        int j = 0;
        int count = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == sub[j]) {
                j++;
                if (j == sub.size()) {
                    count++;
                    j = 0;
                    if (count == k) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
};