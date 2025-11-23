#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class WordFilter {
public:
    WordFilter(vector<string>& words) {
        for (int i = 0; i < words.size(); ++i) {
            string word = words[i];
            int n = word.size();
            for (int j = 0; j <= n; ++j) {
                string prefix = word.substr(0, j);
                for (int k = 0; k <= n; ++k) {
                    string suffix = word.substr(n - k, k);
                    m[prefix + "#" + suffix] = i;
                }
            }
        }
    }

    int f(string prefix, string suffix) {
        string key = prefix + "#" + suffix;
        if (m.count(key)) {
            return m[key];
        } else {
            return -1;
        }
    }

private:
    unordered_map<string, int> m;
};