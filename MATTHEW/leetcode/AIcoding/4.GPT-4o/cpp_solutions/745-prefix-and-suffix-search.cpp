class WordFilter {
public:
    unordered_map<string, int> mp;

    WordFilter(vector<string>& words) {
        for (int i = 0; i < words.size(); i++) {
            string word = words[i];
            for (int j = 0; j <= word.size(); j++) {
                string prefix = word.substr(0, j);
                for (int k = 0; k <= word.size(); k++) {
                    string suffix = word.substr(k);
                    mp[prefix + "#" + suffix] = i + 1;
                }
            }
        }
    }

    int f(string prefix, string suffix) {
        string key = prefix + "#" + suffix;
        return mp.count(key) ? mp[key] - 1 : -1;
    }
};