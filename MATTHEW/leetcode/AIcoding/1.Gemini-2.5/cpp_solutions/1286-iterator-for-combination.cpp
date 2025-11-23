#include <string>
#include <vector>

class CombinationIterator {
private:
    std::vector<std::string> combinations;
    int current_index;

    void generateCombinations(const std::string& chars, int len, int start_idx, std::string current_comb) {
        if (current_comb.length() == len) {
            combinations.push_back(current_comb);
            return;
        }

        if (start_idx >= chars.length() || (chars.length() - start_idx) < (len - current_comb.length())) {
            return;
        }

        generateCombinations(chars, len, start_idx + 1, current_comb + chars[start_idx]);

        generateCombinations(chars, len, start_idx + 1, current_comb);
    }

public:
    CombinationIterator(std::string characters, int combinationLength) {
        current_index = 0;
        generateCombinations(characters, combinationLength, 0, "");
    }

    std::string next() {
        return combinations[current_index++];
    }

    bool hasNext() {
        return current_index < combinations.size();
    }
};