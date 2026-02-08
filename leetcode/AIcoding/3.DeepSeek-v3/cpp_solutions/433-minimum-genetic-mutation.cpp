class Solution {
public:
    int minMutation(string start, string end, vector<string>& bank) {
        unordered_set<string> bankSet(bank.begin(), bank.end());
        if (bankSet.find(end) == bankSet.end()) return -1;

        queue<string> q;
        q.push(start);
        unordered_set<string> visited;
        visited.insert(start);

        int mutations = 0;
        vector<char> nucleotides = {'A', 'C', 'G', 'T'};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string current = q.front();
                q.pop();
                if (current == end) return mutations;

                for (int j = 0; j < current.size(); ++j) {
                    char original = current[j];
                    for (char c : nucleotides) {
                        if (c == original) continue;
                        current[j] = c;
                        if (bankSet.find(current) != bankSet.end() && visited.find(current) == visited.end()) {
                            q.push(current);
                            visited.insert(current);
                        }
                    }
                    current[j] = original;
                }
            }
            mutations++;
        }

        return -1;
    }
};