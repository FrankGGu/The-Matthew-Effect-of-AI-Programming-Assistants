class Solution {
public:
    bool queryString(string S, int N) {
        for (int i = 1; i <= N; ++i) {
            string binary = bitset<32>(i).to_string();
            binary = binary.substr(binary.find('1'));
            if (S.find(binary) == string::npos) {
                return false;
            }
        }
        return true;
    }
};