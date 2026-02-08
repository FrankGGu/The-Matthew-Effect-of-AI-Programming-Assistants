class WordFilter {
private:
    unordered_map<string, int> dict;

public:
    WordFilter(vector<string>& words) {
        for (int k = 0; k < words.size(); ++k) {
            string word = words[k];
            int n = word.size();
            for (int i = 0; i <= n; ++i) {
                string prefix = word.substr(0, i);
                for (int j = 0; j <= n; ++j) {
                    string suffix = word.substr(n - j, j);
                    string key = prefix + "#" + suffix;
                    dict[key] = k;
                }
            }
        }
    }

    int f(string prefix, string suffix) {
        string key = prefix + "#" + suffix;
        if (dict.find(key) != dict.end()) {
            return dict[key];
        }
        return -1;
    }
};