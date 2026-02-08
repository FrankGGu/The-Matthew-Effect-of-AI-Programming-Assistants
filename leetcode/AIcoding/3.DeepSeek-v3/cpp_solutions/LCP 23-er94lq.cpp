class Solution {
public:
    bool isMagic(vector<int>& target) {
        int n = target.size();
        vector<int> original(n);
        for (int i = 0; i < n; ++i) {
            original[i] = i + 1;
        }

        for (int k = 1; k <= n; ++k) {
            vector<int> temp = original;
            bool valid = true;
            int pos = 0;
            while (pos < n) {
                vector<int> odd, even;
                for (int i = 0; i < temp.size(); ++i) {
                    if (i % 2 == 1) {
                        odd.push_back(temp[i]);
                    } else {
                        even.push_back(temp[i]);
                    }
                }
                temp = odd;
                temp.insert(temp.end(), even.begin(), even.end());

                int m = min(k, (int)temp.size());
                for (int i = 0; i < m; ++i) {
                    if (pos + i >= n || temp[i] != target[pos + i]) {
                        valid = false;
                        break;
                    }
                }
                if (!valid) break;
                pos += m;
                if (m < k) break;
                temp.erase(temp.begin(), temp.begin() + m);
            }
            if (valid) return true;
        }
        return false;
    }
};