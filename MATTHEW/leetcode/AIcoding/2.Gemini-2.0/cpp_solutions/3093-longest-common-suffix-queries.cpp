#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> longestCommonSuffix(vector<string>& strs, vector<vector<int>>& queries) {
        vector<int> ans;
        for (auto& query : queries) {
            int idx1 = query[0];
            int idx2 = query[1];
            string s1 = strs[idx1];
            string s2 = strs[idx2];
            int len1 = s1.length();
            int len2 = s2.length();
            int i = len1 - 1;
            int j = len2 - 1;
            int count = 0;
            while (i >= 0 && j >= 0 && s1[i] == s2[j]) {
                count++;
                i--;
                j--;
            }
            ans.push_back(count);
        }
        return ans;
    }
};