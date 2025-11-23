#include <vector>
using namespace std;

class DataFrame {
public:
    vector<int> shape();
};

class Solution {
public:
    vector<int> getDataframeSize(DataFrame& df) {
        return df.shape();
    }
};