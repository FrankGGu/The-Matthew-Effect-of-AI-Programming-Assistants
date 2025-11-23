class Solution {
public:
    vector<int> movesToStamp(string stamp, string target) {
        int sLen = stamp.size(), tLen = target.size();
        vector<int> result;
        vector<bool> stamped(tLen, false);
        int count = 0;

        auto canStamp = [&](int start) {
            bool can = false;
            for (int i = 0; i < sLen; i++) {
                if (start + i < tLen && (target[start + i] == '?' || stamp[i] == target[start + i])) {
                    continue;
                } else {
                    return false;
                }
            }
            return true;
        };

        auto doStamp = [&](int start) {
            for (int i = 0; i < sLen; i++) {
                if (start + i < tLen && target[start + i] != '?') {
                    target[start + i] = '?';
                    count++;
                }
            }
            result.push_back(start);
        };

        while (count < tLen) {
            bool stampedInThisRound = false;
            for (int i = 0; i <= tLen - sLen; i++) {
                if (canStamp(i)) {
                    doStamp(i);
                    stampedInThisRound = true;
                }
            }
            if (!stampedInThisRound) break;
        }

        if (count < tLen) return {};
        reverse(result.begin(), result.end());
        return result;
    }
};