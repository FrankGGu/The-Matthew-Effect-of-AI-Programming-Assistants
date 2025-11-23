class Solution {
public:
    bool areAlmostEqual(std::string s1, std::string s2) {
        if (s1 == s2) {
            return true;
        }

        std::vector<int> diff_indices;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] != s2[i]) {
                diff_indices.push_back(i);
            }
        }

        if (diff_indices.size() == 2) {
            int i = diff_indices[0];
            int j = diff_indices[1];
            return (s1[i] == s2[j] && s1[j] == s2[i]);
        }

        return false;
    }
};