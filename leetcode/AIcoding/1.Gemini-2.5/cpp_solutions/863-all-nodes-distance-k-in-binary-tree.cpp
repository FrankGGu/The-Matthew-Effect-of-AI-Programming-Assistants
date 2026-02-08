#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    void find_parents(TreeNode* node, TreeNode* parent, std::unordered_map<TreeNode*, TreeNode*>& parent_map) {
        if (!node) {
            return;
        }
        parent_map[node] = parent;
        find_parents(node->left, node, parent_map);
        find_parents(node->right, node, parent_map);
    }

    std::vector<int> distanceK(TreeNode* root, TreeNode* target, int k) {
        std::unordered_map<TreeNode*, TreeNode*> parent_map;
        find_parents(root, nullptr, parent_map);

        std::queue<std::pair<TreeNode*, int>> q;
        std::unordered_set<TreeNode*> visited;
        std::vector<int> result;

        q.push({target, 0});
        visited.insert(target);

        while (!q.empty()) {
            TreeNode* current_node = q.front().first;
            int current_dist = q.front().second;
            q.pop();

            if (current_dist == k) {
                result.push_back(current_node->val);
                continue; 
            }

            if (current_dist > k) {
                continue;
            }

            // Explore left child
            if (current_node->left && visited.find(current_node->left) == visited.end()) {
                q.push({current_node->left, current_dist + 1});
                visited.insert(current_node->left);
            }

            // Explore right child
            if (current_node->right && visited.find(current_node->right) == visited.end()) {
                q.push({current_node->right, current_dist + 1});
                visited.insert(current_node->right);
            }

            // Explore parent
            if (parent_map.count(current_node) && parent_map[current_node] && visited.find(parent_map[current_node]) == visited.end()) {
                q.push({parent_map[current_node], current_dist + 1});
                visited.insert(parent_map[current_node]);
            }
        }

        return result;
    }
};