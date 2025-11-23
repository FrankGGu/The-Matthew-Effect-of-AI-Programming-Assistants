#include <vector>

using namespace std;

class Solution {
public:
    vector<int> decode(vector<int>& encoded, int first) {
        int n = encoded.size() + 1;
        vector<int> decoded(n);
        decoded[0] = first;
        for (int i = 0; i < encoded.size(); ++i) {
            decoded[i + 1] = decoded[i] ^ encoded[i];
        }
        return decoded;
    }
};