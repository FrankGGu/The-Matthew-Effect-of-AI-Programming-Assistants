class CombinationIterator {
private:
    vector<string> combinations;
    int index;

    void generateCombinations(const string& characters, int length, int start, string current) {
        if (current.length() == length) {
            combinations.push_back(current);
            return;
        }
        for (int i = start; i < characters.size(); ++i) {
            current.push_back(characters[i]);
            generateCombinations(characters, length, i + 1, current);
            current.pop_back();
        }
    }

public:
    CombinationIterator(string characters, int combinationLength) {
        generateCombinations(characters, combinationLength, 0, "");
        index = 0;
    }

    string next() {
        return combinations[index++];
    }

    bool hasNext() {
        return index < combinations.size();
    }
};