#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int findContentChildren(vector<int>& g, vector<int>& s) {
        sort(g.begin(), g.end());
        sort(s.begin(), s.end());

        int child_index = 0;
        int cookie_index = 0;
        int content_children = 0;

        while (child_index < g.size() && cookie_index < s.size()) {
            if (s[cookie_index] >= g[child_index]) {
                content_children++;
                child_index++;
                cookie_index++;
            } else {
                cookie_index++;
            }
        }

        return content_children;
    }
};