class CombinationIterator {
    constructor(characters, combinationLength) {
        this.combinations = [];
        this.index = 0;
        this.generateCombinations(characters, combinationLength, "", 0);
    }

    generateCombinations(characters, length, current, start) {
        if (current.length === length) {
            this.combinations.push(current);
            return;
        }
        for (let i = start; i < characters.length; i++) {
            this.generateCombinations(characters, length, current + characters[i], i + 1);
        }
    }

    next() {
        return this.combinations[this.index++];
    }

    hasNext() {
        return this.index < this.combinations.length;
    }
}