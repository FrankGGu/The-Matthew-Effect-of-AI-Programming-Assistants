#include <string>
#include <vector>
#include <map>

class WordFilter {
public:
    std::map<std::string, int> memo;

    WordFilter(std::vector<std::string>& words) {
        for (int i = 0; i < words.size(); ++i) {
            std::string word = words[i];
            int n = word.length();

            // Generate all possible prefixes
            for (int j = 0; j <= n; ++j) {
                std::string p = word.substr(0, j);
                // Generate all possible suffixes
                for (int k = 0; k <= n; ++k) {
                    std::string s = word.substr(k);
                    // Combine prefix and suffix with a delimiter and store the word's index
                    // We store the current index 'i' because we want the largest index if multiple words match
                    // Since we iterate 'i' in increasing order, the last stored 'i' for a key will be the largest.
                    memo[p + "#" + s] = i;
                }
            }
        }
    }

    int f(std::string prefix, std::string suffix) {
        std::string key = prefix + "#" + suffix;
        auto it = memo.find(key);
        if (it != memo.end()) {
            return it->second;
        }
        return -1;
    }
};