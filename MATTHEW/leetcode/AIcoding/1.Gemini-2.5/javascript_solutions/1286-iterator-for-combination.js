var CombinationIterator = function(characters, combinationLength) {
    this.chars = characters;
    this.len = combinationLength;
    this.n = characters.length;
    this.indices = new Array(combinationLength);

    for (let i = 0; i < combinationLength; i++) {
        this.indices[i] = i;
    }

    this._hasNext = true;
};

CombinationIterator.prototype.next = function() {
    let currentCombination = '';
    for (let i = 0; i < this.len; i++) {
        currentCombination += this.chars[this.indices[i]];
    }

    let i = this.len - 1;
    while (i >= 0 && this.indices[i] === this.n - (this.len - i)) {
        i--;
    }

    if (i < 0) {
        this._hasNext = false;
    } else {
        this.indices[i]++;
        for (let j = i + 1; j < this.len; j++) {
            this.indices[j] = this.indices[j - 1] + 1;
        }
    }

    return currentCombination;
};

CombinationIterator.prototype.hasNext = function() {
    return this._hasNext;
};