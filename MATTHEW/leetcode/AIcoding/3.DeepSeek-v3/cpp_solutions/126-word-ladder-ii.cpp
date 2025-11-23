class Solution {
public:
    vector<vector<string>> findLadders(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> dict(wordList.begin(), wordList.end());
        vector<vector<string>> res;
        if (dict.find(endWord) == dict.end()) return res;

        unordered_map<string, vector<string>> neighbors;
        unordered_map<string, int> distance;
        vector<string> path;

        dict.insert(beginWord);
        bfs(beginWord, endWord, dict, neighbors, distance);
        dfs(beginWord, endWord, neighbors, distance, path, res);
        return res;
    }

private:
    void bfs(string beginWord, string endWord, unordered_set<string>& dict, 
             unordered_map<string, vector<string>>& neighbors, unordered_map<string, int>& distance) {
        queue<string> q;
        q.push(beginWord);
        distance[beginWord] = 0;

        while (!q.empty()) {
            bool found = false;
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string curr = q.front();
                q.pop();
                int currDist = distance[curr];
                vector<string> nbrs = getNeighbors(curr, dict);
                for (string next : nbrs) {
                    neighbors[curr].push_back(next);
                    if (distance.find(next) == distance.end()) {
                        distance[next] = currDist + 1;
                        if (next == endWord) {
                            found = true;
                        } else {
                            q.push(next);
                        }
                    }
                }
            }
            if (found) break;
        }
    }

    vector<string> getNeighbors(string word, unordered_set<string>& dict) {
        vector<string> res;
        for (int i = 0; i < word.size(); ++i) {
            char old = word[i];
            for (char c = 'a'; c <= 'z'; ++c) {
                if (c == old) continue;
                word[i] = c;
                if (dict.find(word) != dict.end()) {
                    res.push_back(word);
                }
            }
            word[i] = old;
        }
        return res;
    }

    void dfs(string currWord, string endWord, unordered_map<string, vector<string>>& neighbors, 
             unordered_map<string, int>& distance, vector<string>& path, vector<vector<string>>& res) {
        path.push_back(currWord);
        if (currWord == endWord) {
            res.push_back(path);
        } else {
            for (string next : neighbors[currWord]) {
                if (distance[next] == distance[currWord] + 1) {
                    dfs(next, endWord, neighbors, distance, path, res);
                }
            }
        }
        path.pop_back();
    }
};