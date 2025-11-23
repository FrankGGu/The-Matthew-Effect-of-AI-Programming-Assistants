#include <vector>

class Solution {
public:
    std::vector<int> decode(std::vector<int>& encoded, int first) {
        std::vector<int> arr(encoded.size() + 1);
        arr[0] = first;

        for (int i = 0; i < encoded.size(); ++i) {
            arr[i+1] = encoded[i] ^ arr[i];
        }

        return arr;
    }
};