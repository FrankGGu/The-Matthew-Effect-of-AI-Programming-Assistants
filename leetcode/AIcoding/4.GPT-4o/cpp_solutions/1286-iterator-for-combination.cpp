class CombinationIterator {
public:
    CombinationIterator(string characters, int combinationLength) {
        this->characters = characters;
        this->combinationLength = combinationLength;
        index = 0;
        totalCombinations = 1;
        for (int i = 0; i < combinationLength; i++) {
            totalCombinations *= characters.size() - i;
            totalCombinations /= (i + 1);
        }
        generateCombinations("", 0);
    }

    string next() {
        return combinations[index++];
    }

    bool hasNext() {
        return index < combinations.size();
    }

private:
    string characters;
    int combinationLength;
    vector<string> combinations;
    int index;

    void generateCombinations(string current, int start) {
        if (current.size() == combinationLength) {
            combinations.push_back(current);
            return;
        }
        for (int i = start; i < characters.size(); i++) {
            generateCombinations(current + characters[i], i + 1);
        }
    }
};