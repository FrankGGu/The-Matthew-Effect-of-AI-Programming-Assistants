class Solution {
public:
    bool areSentencesSimilar(std::vector<std::string>& sentence1, std::vector<std::string>& sentence2) {
        int n1 = sentence1.size();
        int n2 = sentence2.size();

        if (n1 == n2) {
            return sentence1 == sentence2;
        }

        if (n1 < n2) {
            std::swap(sentence1, sentence2);
            std::swap(n1, n2);
        }

        for (int i = 0; i <= n1 - n2; ++i) {
            bool match = true;
            for (int j = 0; j < n2; ++j) {
                if (sentence1[i + j] != sentence2[j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return true;
            }
        }

        return false;
    }
};