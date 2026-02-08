#include <iostream>
#include <vector>
#include <unordered_map>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    vector<int> findMode(TreeNode* root) {
        vector<int> result;
        unordered_map<int, int> freqMap;
        int maxFreq = 0;

                function<void(TreeNode*)> inorder = [&](TreeNode* node) {
            if (!node) return;
            inorder(node->left);
            freqMap[node->val]++;
            maxFreq = max(maxFreq, freqMap[node->val]);
            inorder(node->right);
        };

        inorder(root);

                for (const auto& pair : freqMap) {
            if (pair.second == maxFreq) {
                result.push_back(pair.first);
            }
        }

        return result;
    }
};