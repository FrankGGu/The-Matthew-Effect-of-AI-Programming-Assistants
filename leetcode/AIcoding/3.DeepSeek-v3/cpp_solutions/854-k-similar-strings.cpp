class Solution {
public:
    int kSimilarity(string s1, string s2) {
        queue<string> q;
        unordered_set<string> visited;
        q.push(s1);
        visited.insert(s1);
        int k = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string current = q.front();
                q.pop();
                if (current == s2) {
                    return k;
                }
                int j = 0;
                while (j < current.size() && current[j] == s2[j]) {
                    j++;
                }
                for (int l = j + 1; l < current.size(); ++l) {
                    if (current[l] == s2[j] && current[l] != s2[l]) {
                        swap(current[j], current[l]);
                        if (visited.find(current) == visited.end()) {
                            visited.insert(current);
                            q.push(current);
                        }
                        swap(current[j], current[l]);
                    }
                }
            }
            k++;
        }
        return -1;
    }
};