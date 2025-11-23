class Solution {
public:
    int countMatches(const std::string& s1, const std::string& s2) {
        int matches = 0;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] == s2[i]) {
                matches++;
            }
        }
        return matches;
    }

    void findSecretWord(std::vector<std::string>& wordlist, Master& master) {
        std::vector<std::string> possibleWords = wordlist;

        for (int i = 0; i < 10; ++i) {
            if (possibleWords.empty()) {
                break;
            }

            std::string guessWord = "";
            int minMaxBucketSize = std::numeric_limits<int>::max();

            for (const std::string& candidateWord : possibleWords) {
                std::map<int, int> bucketSizes; 

                for (const std::string& otherWord : possibleWords) {
                    bucketSizes[countMatches(candidateWord, otherWord)]++;
                }

                int currentMaxBucketSize = 0;
                for (auto const& [matches, count] : bucketSizes) {
                    currentMaxBucketSize = std::max(currentMaxBucketSize, count);
                }

                if (currentMaxBucketSize < minMaxBucketSize) {
                    minMaxBucketSize = currentMaxBucketSize;
                    guessWord = candidateWord;
                }
            }

            int matches = master.guess(guessWord);

            if (matches == 6) {
                return;
            }

            std::vector<std::string> nextPossibleWords;
            for (const std::string& word : possibleWords) {
                if (countMatches(guessWord, word) == matches) {
                    nextPossibleWords.push_back(word);
                }
            }
            possibleWords = nextPossibleWords;
        }
    }
};