class Codec {
public:

    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        if (!root) return "";
        string s;
        stack<TreeNode*> st;
        st.push(root);
        while (!st.empty()) {
            TreeNode* node = st.top();
            st.pop();
            if (node) {
                s += to_string(node->val) + ",";
                st.push(node->right);
                st.push(node->left);
            }
        }
        return s;
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        if (data.empty()) return nullptr;
        stringstream ss(data);
        string token;
        vector<int> nums;
        while (getline(ss, token, ',')) {
            nums.push_back(stoi(token));
        }
        return helper(nums, 0, nums.size() - 1);
    }

    TreeNode* helper(vector<int>& nums, int left, int right) {
        if (left > right) return nullptr;
        TreeNode* root = new TreeNode(nums[left]);
        int mid = left + 1;
        while (mid <= right && nums[mid] < nums[left]) {
            mid++;
        }
        root->left = helper(nums, left + 1, mid - 1);
        root->right = helper(nums, mid, right);
        return root;
    }
};