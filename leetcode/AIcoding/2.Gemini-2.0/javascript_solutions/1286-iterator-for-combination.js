var CombinationIterator = function(characters, combinationLength) {
    this.characters = characters;
    this.combinationLength = combinationLength;
    this.combinations = [];
    this.generateCombinations(0, "", 0);
    this.index = 0;
};

CombinationIterator.prototype.generateCombinations = function(index, current, count) {
    if (count === this.combinationLength) {
        this.combinations.push(current);
        return;
    }

    if (index === this.characters.length) {
        return;
    }

    this.generateCombinations(index + 1, current + this.characters[index], count + 1);
    this.generateCombinations(index + 1, current, count);
};

CombinationIterator.prototype.next = function() {
    return this.combinations[this.index++];
};

CombinationIterator.prototype.hasNext = function() {
    return this.index < this.combinations.length;
};