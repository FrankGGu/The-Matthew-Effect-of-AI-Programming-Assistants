#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> maxDepthAfterSplit(string seq) {
        int depth = 0;
        vector<int> ans(seq.size());
        for (int i = 0; i < seq.size(); ++i) {
            if (seq[i] == '(') {
                depth++;
                ans[i] = depth % 2;
            } else {
                ans[i] = depth % 2;
                depth--;
            }
        }
        return ans;
    }
};