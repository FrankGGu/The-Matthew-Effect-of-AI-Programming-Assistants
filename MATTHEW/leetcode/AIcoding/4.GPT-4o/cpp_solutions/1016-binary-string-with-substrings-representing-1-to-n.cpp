class Solution {
public:
    bool queryString(string S, int N) {
        if (N > (1 << S.size()) - 1) return false;
        for (int i = 1; i <= N; i++) {
            bitset<32> b(i);
            if (S.find(b.to_string().substr(32 - b.count())) == string::npos) {
                return false;
            }
        }
        return true;
    }
};