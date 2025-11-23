var CombinationIterator = function(characters, combinationLength) {
    this.combinations = [];
    this.index = 0;

    const backtrack = (start, path) => {
        if (path.length === combinationLength) {
            this.combinations.push(path.join(''));
            return;
        }
        for (let i = start; i < characters.length; i++) {
            path.push(characters[i]);
            backtrack(i + 1, path);
            path.pop();
        }
    };

    backtrack(0, []);
};

CombinationIterator.prototype.next = function() {
    return this.combinations[this.index++];
};

CombinationIterator.prototype.hasNext = function() {
    return this.index < this.combinations.length;
};