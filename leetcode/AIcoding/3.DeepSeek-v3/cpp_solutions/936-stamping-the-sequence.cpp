class Solution {
public:
    vector<int> movesToStamp(string stamp, string target) {
        vector<int> res;
        int total = 0, turn = -1;
        while (turn) {
            turn = 0;
            for (int sz = stamp.size(); sz > 0; --sz) {
                for (int i = 0; i <= stamp.size() - sz; ++i) {
                    string new_stamp = string(i, '?') + stamp.substr(i, sz) + string(stamp.size() - sz - i, '?');
                    auto pos = target.find(new_stamp);
                    while (pos != string::npos) {
                        res.push_back(pos);
                        turn += sz;
                        fill(target.begin() + pos, target.begin() + pos + stamp.size(), '?');
                        pos = target.find(new_stamp);
                    }
                }
            }
            total += turn;
        }
        reverse(res.begin(), res.end());
        return total == target.size() ? res : vector<int>();
    }
};