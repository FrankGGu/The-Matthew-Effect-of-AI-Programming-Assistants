#include <string>
#include <stack>
#include <utility> // For std::pair

class Solution {
public:
    TreeNode* recoverFromPreorder(std::string S) {
        std::stack<std::pair<TreeNode*, int>> s; 
        int i = 0;

        while (i < S.length()) {
            int depth = 0;
            while (i < S.length() && S[i] == '-') {
                depth++;
                i++;
            }

            int val = 0;
            while (i < S.length() && S[i] >= '0' && S[i] <= '9') {
                val = val * 10 + (S[i] - '0');
                i++;
            }

            TreeNode* newNode = new TreeNode(val);

            if (s.empty()) {
                s.push({newNode, depth});
            } else {
                while (!s.empty() && s.top().second >= depth) {
                    s.pop();
                }

                TreeNode* parent = s.top().first;

                if (parent->left == nullptr) {
                    parent->left = newNode;
                } else {
                    parent->right = newNode;
                }

                s.push({newNode, depth});
            }
        }

        while (s.top().second != 0) {
            s.pop();
        }
        return s.top().first;
    }
};