#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <sstream>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    TreeNode* recoverFromPreorder(string S) {
        if (S.empty()) return nullptr;

        stack<TreeNode*> st;
        int i = 0;
        int depth = 0;
        string numStr;

        while (i < S.size()) {
            if (S[i] == '-') {
                depth++;
                i++;
            } else {
                numStr.clear();
                while (i < S.size() && S[i] != '-') {
                    numStr += S[i];
                    i++;
                }
                int val = stoi(numStr);
                TreeNode* node = new TreeNode(val);

                while (st.size() > depth) {
                    st.pop();
                }

                if (!st.empty()) {
                    if (st.top()->left == nullptr) {
                        st.top()->left = node;
                    } else {
                        st.top()->right = node;
                    }
                }

                st.push(node);
                depth = 0;
            }
        }

        return st.empty() ? nullptr : st.top();
    }
};