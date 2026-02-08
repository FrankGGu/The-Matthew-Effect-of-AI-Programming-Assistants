var CombinationIterator = function(characters, n) {
    this.characters = characters;
    this.n = n;
    this.currentIndex = 0;
    this.combinations = [];

    const generateCombinations = (start, current) => {
        if (current.length === n) {
            this.combinations.push(current.join(''));
            return;
        }
        for (let i = start; i < characters.length; i++) {
            current.push(characters[i]);
            generateCombinations(i + 1, current);
            current.pop();
        }
    };

    generateCombinations(0, []);
};

CombinationIterator.prototype.next = function() {
    return this.combinations[this.currentIndex++];
};

CombinationIterator.prototype.hasNext = function() {
    return this.currentIndex < this.combinations.length;
};